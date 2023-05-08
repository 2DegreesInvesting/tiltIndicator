#' Calculate input (or product) carbon transition risk
#'
#' These functions calculate the input (or product) carbon transition risk. The
#' process is the same. What varies is the `co2` dataset.
#'
#' ### Depracated
#'
#' The `ictr*()` and `pctr*()` functions are now deprecated. Use the `xctr*()`
#' functions instead.
#'
#' ### Input carbon transition risk (ICTR)
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' ### Product carbon transition risk (PCTR)
#'
#' ```{r child=extdata_path("child/intro-pctr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [ictr_companies].
#' @param co2 A dataframe like [inputs].
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#' @param data A dataframe. The output at product level.
#'
#' @family XCTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- ictr_companies
#'
#' # ICTR
#' inputs <- inputs
#'
#' companies |>
#'   xctr_at_product_level(co2 = inputs)
#'
#' companies |>
#'   xctr_at_product_level(co2 = inputs) |>
#'   xctr_at_company_level()
#'
#' # Same
#' companies |> xctr(co2 = inputs)
#'
#' # PCTR
#' products <- products
#'
#' companies |>
#'   xctr_at_product_level(co2 = products)
#'
#' companies |>
#'   xctr_at_product_level(co2 = products) |>
#'   xctr_at_company_level()
#'
#' # Same
#' companies |> xctr(co2 = products)
xctr <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  companies |>
    xctr_at_product_level(co2, low_threshold, high_threshold) |>
    xctr_at_company_level()
}

#' Deprecated
#' @export
#' @keywords internal
ictr <- xctr
#' Deprecated
#' @export
#' @keywords internal
pctr <- xctr

#' @export
#' @rdname xctr
xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  xctr_check(companies, co2)

  # #230
  co2 <- distinct(co2)
  companies <- distinct(companies)

  co2 |>
    xctr_rename() |>
    xctr_add_ranks(col_to_rank(co2)) |>
    xctr_add_scores(low_threshold, high_threshold) |>
    xctr_join_companies(companies) |>
    xctr_polish_output_at_product_level()
}
#' Deprecated
#' @export
#' @keywords internal
ictr_at_product_level <- xctr_at_product_level
#' Deprecated
#' @export
#' @keywords internal
pctr_at_product_level <- xctr_at_product_level

#' @export
#' @rdname xctr
xctr_at_company_level <- function(data) {
  benchmarks <- xctr_combined_benchmarks()

  data |>
    # FIXME: Instead rename downstream
    rename(company_id = "companies_id") |>
    # FIXME: Instead handle data in long format
    xctr_pivot_grouped_by_to_score() |>
    xctr_at_company_level_impl(benchmarks) |>
    xctr_polish_output_at_company_level()
}
#' Deprecated
#' @export
#' @keywords internal
ictr_at_company_level <- xctr_at_company_level
#' Deprecated
#' @export
#' @keywords internal
pctr_at_company_level <- xctr_at_company_level

xctr_at_company_level_impl <- function(data, benchmarks) {
  # For each company show all risk levels even if the share is 0.
  template <- tibble(
    company_id = rep(unique(data$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(data$company_id))),
  )

  .benchmarks <- map(benchmarks, ~ add_share(data, .x))

  ictr_output <- append(list(template), .benchmarks) |>
    reduce(left_join, by = c("company_id", "score"))

  ictr_output |>
    mutate(
      across(starts_with("share_"), na_to_0_if_not_all_is_na),
      .by = "company_id"
    )
}

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

xctr_score_companies <- function(companies,
                                 co2,
                                 uuid = "activity_uuid_product_uuid",
                                 .by = c("all", "unit", "sector", "unit_sec")) {
  stopifnot(hasName(companies, "company_id"))

  companies_scores <- left_join(companies, co2, by = c(uuid))

  # For each company show all risk levels even if the share is 0.
  dt_sceleton <- tibble(
    company_id = rep(unique(companies_scores$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(companies_scores$company_id))),
  )

  # Share in comparison to all inputs and those with same unit, sector, ...
  benchmarks_list <- map(.by, ~ add_share(companies_scores, .x))

  ictr_output <- append(list(dt_sceleton), benchmarks_list) |>
    reduce(left_join, by = c("company_id", "score"))

  ictr_output |>
    mutate(
      across(starts_with("share_"), na_to_0_if_not_all_is_na),
      .by = "company_id"
    )
}

xctr_add_ranks <- function(data, x) {
  .by <- xctr_benchmarks()
  out <- distinct(data)
  for (i in seq_along(.by)) {
    out <- add_rank(out, x, .by = .by[[i]])
  }
  out
}

find_col <- function(data, pattern) {
  grep(pattern, names(data), value = TRUE)
}

add_rank <- function(data, x, .by) {
  if (identical(.by, "all")) {
    benchmark <- "all"
    ..by <- NULL
  } else {
    benchmark <- paste(.by, collapse = "_")
    ..by <- .by
  }

  nm <- as.symbol(paste0("perc_", benchmark))
  mutate(data, "{{ nm }}" := rank_proportion(.data[[x]]), .by = all_of(..by))
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

xctr_add_scores <- function(data, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  for (col in colnames(select(data, starts_with("perc_")))) {
    new_col <- gsub("perc_", "score_", col)
    data <- data |> mutate({{ new_col }} := case_when(
      .data[[col]] <= low_threshold ~ "low",
      .data[[col]] > low_threshold & .data[[col]] <= high_threshold ~ "medium",
      .data[[col]] > high_threshold ~ "high"
    ))
  }
  data
}

xctr_check <- function(companies, co2) {
  stopifnot(hasName(companies, "company_id"))
  stopifnot(any(grepl("co2_footprint", names(co2))))
  stopifnot(any(grepl("tilt_sector", names(co2))))
  stopifnot(any(grepl("isic_4digit", names(co2))))
  stop_if_col_to_rank_has_missing_values(co2)
}

xctr_rename <- function(data) {
  data |>
    rename(
      tilt_sec = ends_with("tilt_sector"),
      unit = ends_with("unit"),
      isic_sec = ends_with("isic_4digit")
    )
}

xctr_join_companies <- function(product_level, companies) {
  left_join(
    companies,
    product_level,
    by = "activity_uuid_product_uuid",
    relationship = "many-to-many"
  )
}

xctr_benchmarks <- function() {
  list(
    "all",
    "isic_sec",
    "tilt_sec",
    "unit",
    c("unit", "isic_sec"),
    c("unit", "tilt_sec")
  )
}

xctr_combined_benchmarks <- function() {
  xctr_benchmarks() |>
    lapply(paste, collapse = "_") |>
    unlist() |>
    unique()
}

stop_if_col_to_rank_has_missing_values <- function(co2) {
  if (anyNA(co2[[col_to_rank(co2)]])) {
    stop(col_to_rank(co2), " can't have missing values.")
  }
}

col_to_rank <- function(co2, pattern = "co2_footprint") {
  find_col(co2, pattern)
}

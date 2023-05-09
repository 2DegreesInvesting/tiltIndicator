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

xctr_check <- function(companies, co2) {
  crucial <- c("company_id")
  walk(crucial, ~ stop_if_lacks_name(companies, .x))

  crucial <- c("co2_footprint", "tilt_sector", "isic_4digit")
  walk(crucial, ~ stop_if_lacks_name(co2, .x))

  stop_if_col_to_rank_has_missing_values(co2)
  vec_assert(get_column(co2, "isic_4digit"), character())
}

stop_if_lacks_name <- function(data, pattern) {
  if (!matches_name(data, pattern)) {
    abort(c(
      glue("The data lacks a column matching the pattern '{pattern}'."),
      i = "Are you using the correct data?"
    ))
  }
  invisible(data)
}

stop_if_col_to_rank_has_missing_values <- function(co2) {
  if (anyNA(co2[[col_to_rank(co2)]])) {
    stop(col_to_rank(co2), " can't have missing values.")
  }
}

xctr_rename <- function(data) {
  data |>
    rename(
      tilt_sec = ends_with("tilt_sector"),
      unit = ends_with("unit"),
      isic_sec = ends_with("isic_4digit")
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

col_to_rank <- function(co2, pattern = "co2_footprint") {
  extract_name(co2, pattern)
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

xctr_join_companies <- function(product_level, companies) {
  left_join(
    companies,
    product_level,
    by = "activity_uuid_product_uuid",
    relationship = "many-to-many"
  )
}

xctr_polish_output_at_product_level <- function(data) {
  data |>
    xctr_pivot_score_to_grouped_by() |>
    xctr_rename_at_product_level() |>
    select_cols_at_product_level() |>
    prune_unmatched_products()
}

xctr_pivot_score_to_grouped_by <- function(data) {
  data |>
    pivot_longer(
      starts_with("score_"),
      names_prefix = "score_",
      names_to = "grouped_by"
    )
}

xctr_rename_at_product_level <- function(data) {
  data |>
    rename(companies_id = "company_id") |>
    rename(risk_category = "value")
}

select_cols_at_product_level <- function(data) {
  data |>
    select(
      all_of(cols_at_product_level()),
      ends_with("activity_uuid_product_uuid"),
      # Required to uniquely identify rows when using pivot
      ends_with("co2_footprint")
    )
}

prune_unmatched_products <- function(data) {
  filter(data, all_na_else_not_na(.data$risk_category), .by = "companies_id")
}

all_na_else_not_na <- function(x) {
  if (all(is.na(x))) TRUE else !is.na(x)
}

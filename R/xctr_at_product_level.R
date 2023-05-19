#' @export
#' @rdname xctr
xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  xctr_check(companies, co2)

  .companies <- xctr_standardize_companies_names(distinct(companies))
  .co2 <- xctr_standardize_co2_names(distinct(co2))

  out <- .co2 |>
    # FIXME: This is still in an awkward wide format
    xctr_add_ranks(col_metric()) |>
    pivot_longer(
      cols = starts_with("perc_"),
      names_prefix = "perc_",
      names_to = "grouped_by",
      values_to = "values_to_categorize"
    ) |>
    add_risk_category(low_threshold, high_threshold) |>
    xctr_join_companies(.companies) |>
    select_cols_at_product_level() |>
    prune_unmatched_products()

  restore_original_metric_name(out, co2)
}

xctr_check <- function(companies, co2) {
  stop_if_has_0_rows(companies)
  stop_if_has_0_rows(co2)

  crucial <- c("company_id")
  walk(crucial, ~ check_matches_name(companies, .x))

  crucial <- c("co2_footprint", "tilt_sector", "isic_4digit")
  walk(crucial, ~ check_matches_name(co2, .x))

  check_has_no_na(co2, xctr_find_col_metric(co2))
  check_is_character(get_column(co2, "isic_4digit"))
}

xctr_standardize_companies_names <- function(companies) {
  rename(companies, companies_id = "company_id")
}

xctr_standardize_co2_names <- function(co2) {
  co2 |>
    rename(metric = xctr_find_col_metric(co2)) |>
    rename(
      tilt_sec = ends_with("tilt_sector"),
      unit = ends_with("unit"),
      isic_sec = ends_with("isic_4digit")
    )
}

restore_original_metric_name <- function(out, co2) {
  metric_alias <- as.symbol(xctr_find_col_metric(co2))
  rename(out, "{{ metric_alias }}" := col_metric())
}

check_matches_name <- function(data, pattern) {
  if (!matches_name(data, pattern)) {
    abort(c(
      glue("The data lacks a column matching the pattern '{pattern}'."),
      i = "Are you using the correct data?"
    ))
  }
  invisible(data)
}

check_has_no_na <- function(data, name) {
  if (anyNA(data[[name]])) {
    abort(c(
      glue("The column '{name}' can't have missing values."),
      i = glue("Remove them with `dplyr::filter(data, !is.na({name}))`.")
    ))
  }
  invisible(data)
}

check_is_character <- function(x) {
  vec_assert(x, character())
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

flat_benchmarks <- function() {
  map_chr(xctr_benchmarks(), ~ paste(.x, collapse = "_"))
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

xctr_find_col_metric <- function(co2, pattern = "co2_footprint") {
  extract_name(co2, pattern)
}

col_metric <- function() {
  "metric"
}

xctr_join_companies <- function(product_level, companies) {
  left_join(
    companies,
    product_level,
    by = "activity_uuid_product_uuid",
    relationship = "many-to-many"
  )
}

select_cols_at_product_level <- function(data) {
  data |>
    select(
      all_of(cols_at_product_level()),
      ends_with("activity_uuid_product_uuid"),
      # Required to uniquely identify rows when using pivot
      col_metric()
    )
}

prune_unmatched_products <- function(data) {
  filter(data, all_na_else_not_na(.data$risk_category), .by = "companies_id")
}

all_na_else_not_na <- function(x) {
  if (all(is.na(x))) TRUE else !is.na(x)
}

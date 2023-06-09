#' @export
#' @rdname xctr
xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  xctr_check(companies, co2)

  .companies <- prepare_companies(companies)
  .co2 <- prepare_co2(co2, low_threshold, high_threshold)

  .co2 |>
    xctr_add_values_to_categorize() |>
    add_risk_category(low_threshold, high_threshold) |>
    join_companies(.companies) |>
    xctr_select_cols_at_product_level() |>
    polish_output(cols_at_product_level())
}

xctr_check <- function(companies, co2) {
  stop_if_has_0_rows(companies)
  stop_if_has_0_rows(co2)

  crucial <- c("company_id")
  walk(crucial, ~ check_matches_name(companies, .x))

  crucial <- c("co2_footprint", "tilt_sector", "isic_4digit")
  walk(crucial, ~ check_matches_name(co2, .x))

  check_has_no_na(co2, find_co2_footprint(co2))
  check_is_character(get_column(co2, "isic_4digit"))
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

xctr_add_values_to_categorize <- function(data) {
  add_rank <- function(data, .by) {
    if (identical(.by, "all")) .by <- NULL
    mutate(
      data,
      values_to_categorize = rank_proportion(.data[[find_co2_footprint(data)]]),
      .by = all_of(.by)
    )
  }

  benchmarks <- set_names(xctr_benchmarks(), flat_benchmarks())
  map_df(benchmarks, ~ add_rank(data, .x), .id = "grouped_by")
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

rank_proportion <- function(x) {
  rank(x) / length(x)
}

find_co2_footprint <- function(co2, pattern = "co2_footprint") {
  extract_name(co2, pattern)
}

xctr_select_cols_at_product_level <- function(data) {
  data |>
    select(
      all_of(cols_at_product_level()),
      ends_with("activity_uuid_product_uuid"),
      find_co2_footprint(data)
    )
}

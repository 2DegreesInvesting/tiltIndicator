emissions_profile_any_at_product_level <- function(companies,
                                                   co2,
                                                   low_threshold = 1 / 3,
                                                   high_threshold = 2 / 3) {
  co2 <- sanitize_co2(co2)
  x <- list(companies = companies, co2 = co2)
  epa_check(x)

  .companies <- prepare_companies(companies)
  .co2 <- prepare_co2(co2, low_threshold, high_threshold)

  .co2 |>
    epa_compute_profile_ranking() |>
    add_risk_category(low_threshold, high_threshold) |>
    join_companies(.companies) |>
    epa_select_cols_at_product_level() |>
    filter(if_all_na_is_first_else_TRUE(.data[["grouped_by"]]), .by = all_of("companies_id")) |>
    distinct()
}

epa_check <- function(x) {
  stop_if_has_0_rows(x$companies)
  stop_if_has_0_rows(x$co2)

  crucial <- id_pattern()
  check_matches_name(x$companies, crucial)

  crucial <- c(aka("co2footprint"), aka("tsubsector"), aka("isic"), aka("xunit"))
  walk(crucial, ~ check_matches_name(x$co2, .x))

  check_has_no_na(x$co2, find_co2_footprint(x$co2))
  check_is_character(pull_isic(x$co2))

  check_rowid(x)
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

find_co2_footprint <- function(co2, pattern = aka("co2footprint")) {
  extract_name(co2, pattern)
}

epa_select_cols_at_product_level <- function(data) {
  data |>
    select(
      ends_with(rowid()),
      all_of(cols_at_product_level()),
      ends_with(aka("uid")),
      find_co2_footprint(data)
    )
}

if_all_na_is_first_else_TRUE <- function(x) {
  if (all(is.na(x))) is_first(x) else rep(TRUE, length(x))
}

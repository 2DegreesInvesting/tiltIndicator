#' Get path to child extdata/
#'
#' @param path Character. Path to a directory in inst/extdata/.
#' @keywords internal
#' @export
#' @examples
#' extdata_path("")
#' list.files(extdata_path(""), recursive = TRUE)
extdata_path <- function(path) {
  system.file("extdata", path, package = "tiltIndicator", mustWork = TRUE)
}

risk_category_levels <- function() {
  c("high", "medium", "low")
}

categorize_risk <- function(x, low_threshold, high_threshold, ...) {
  case_when(
    x > high_threshold ~ "high",
    x > low_threshold & x <= high_threshold ~ "medium",
    x <= low_threshold ~ "low",
    ...
  )
}

stop_if_has_0_rows <- function(data) {
  label <- deparse(substitute(data))
  if (identical(nrow(data), 0L)) {
    abort(glue("`{label}` can't have 0-row."))
  }
  invisible(data)
}

prepare_companies <- function(data) {
  data |>
    sanitize_id() |>
    distinct()
}

lowercase_characters <- function(data) {
  mutate(data, across(where(is.character), tolower))
}

add_risk_category <- function(data, low_threshold, high_threshold, ...) {
  mutate(data, risk_category = categorize_risk(
    .data$profile_ranking, .data$low_threshold, .data$high_threshold, ...
  ))
}

abort_if_duplicated <- function(data) {
  is_unique <- identical(anyDuplicated(data), 0L)
  if (!is_unique) {
    abort(glue("`data` must be unique by {toString(names(data))}."))
  }
  invisible(data)
}

prune_unmatched <- function(data, col, .by) {
  filter(data, if_all_na_is_first_else_not_na(.data[[col]]), .by = all_of(.by))
}

if_all_na_is_first_else_not_na <- function(x) {
  if (all(is.na(x))) is_first(x) else !is.na(x)
}

is_first <- function(x) {
  seq_along(x) == 1L
}

polish_output <- function(data, na_cols) {
  data |>
    prune_unmatched("risk_category", .by = "companies_id") |>
    spread_na_across(na_cols, from = "risk_category") |>
    distinct()
}

spread_na_across <- function(data, across, from) {
  mutate(data, across(all_of(across), ~ spread_na(.data[[from]], .x)))
}

spread_na <- function(from, to) {
  if_else(is.na(from), NA, to)
}

join_companies <- function(data, companies) {
  left_join(
    companies,
    data,
    by = aka("uid"),
    relationship = "many-to-many"
  )
}

remove_col_scenario <- function(companies) {
  if (hasName(companies, aka("scenario_type"))) {
    companies <- select(companies, -all_of(aka("scenario_type")))
  }
  companies
}

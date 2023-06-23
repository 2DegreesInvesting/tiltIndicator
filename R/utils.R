document_value <- function() {
  paste0(
    "At product level, a dataframe with at least columns ",
    toString(cols_at_all_levels()), ". ",
    "At company level, a dataframe with at least columns ",
    toString(cols_at_company_level()), "."
  )
}

cols_at_all_levels <- function() {
  c("companies_id", "grouped_by", "risk_category")
}

cols_at_product_level <- function() {
  c(cols_at_all_levels(), "clustered", "activity_uuid_product_uuid")
}

cols_at_company_level <- function() {
  c(cols_at_all_levels(), "value")
}

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

extract_name <- function(data, pattern) {
  out <- grep(pattern, names(data), value = TRUE)
  if (identical(out, character(0))) {
    out <- ""
  }
  out
}

matches_name <- function(data, pattern) {
  nzchar(extract_name(data, pattern))
}

is_xctr <- function(data) {
  any(grepl("co2_footprint", names(data)))
}

risk_category_levels <- function() {
  c("high", "medium", "low")
}

get_column <- function(data, pattern) {
  data[[extract_name(data, pattern)]]
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

prepare_companies <- function(companies) {
  companies |>
    distinct() |>
    rename(companies_id = "company_id")
}

prepare_co2 <- function(data, low_threshold, high_threshold) {
  data |>
    mutate(low_threshold = low_threshold, high_threshold = high_threshold) |>
    distinct() |>
    rename(
      tilt_sec = ends_with("tilt_sector"),
      unit = ends_with("unit"),
      isic_sec = ends_with("isic_4digit")
    )
}

prepare_scenarios <- function(data, low_threshold, high_threshold) {
  data |>
    mutate(low_threshold = low_threshold, high_threshold = high_threshold) |>
    distinct() |>
    rename(values_to_categorize = "reductions")
}

lowercase_characters <- function(data) {
  mutate(data, across(where(is.character), tolower))
}

#' Check if a named object contains expected names
#'
#' Based on fgeo.tool::check_crucial_names()
#'
#' @param x A named object.
#' @param expected_names String; expected names of `x`.
#'
#' @return Invisible `x`, or an error with informative message.
#'
#' Adapted from: https://github.com/RMI-PACTA/r2dii.match/blob/main/R/check_crucial_names.R
#'
#' @examples
#' x <- c(a = 1)
#' check_crucial_names(x, "a")
#' try(check_crucial_names(x, "bad"))
#' @noRd
check_crucial_names <- function(x, expected_names) {
  stopifnot(rlang::is_named(x))
  stopifnot(is.character(expected_names))

  ok <- all(unique(expected_names) %in% names(x))
  if (!ok) {
    abort_missing_names(sort(setdiff(expected_names, names(x))))
  }

  invisible(x)
}

abort_missing_names <- function(missing_names) {
  rlang::abort(
    "missing_names",
    message = glue::glue(
      "Must have missing names:
      {paste0('`', missing_names, '`', collapse = ', ')}"
    )
  )
}

add_risk_category <- function(data, low_threshold, high_threshold, ...) {
  mutate(data, risk_category = categorize_risk(
    .data$values_to_categorize, .data$low_threshold, .data$high_threshold, ...
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

handle_unmatched <- function(data, level_cols) {
  na_cols <- setdiff(level_cols, "companies_id")
  data |>
    prune_unmatched("risk_category", .by = "companies_id") |>
    spread_na_across(na_cols, from = "risk_category")
}

spread_na_across <- function(data, across, from) {
  mutate(data, across(all_of(across), ~ spread_na(.data[[from]], .x)))
}
spread_na <- function(from, to) {
  if_else(is.na(from), NA, to)
}

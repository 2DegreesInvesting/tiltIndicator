document_dataset <- function() {
  paste0(
    "A dataframe like the dataset with a matching name in tiltToyData (see ",
    "[Reference](https://2degreesinvesting.github.io/tiltToyData/reference/index.html))"
  )
}

document_value <- function() {
  paste0(document_default_value(), " ", document_optional_rowid())
}

document_default_value <- function() {
  at_all_levels <- toString(paste0("`", cols_at_all_levels(), "`"))
  at_company_level <- toString(paste0("`", cols_at_company_level(), "`"))

  paste0(
    "A data frame with the column `companies_id`, and the nested columns",
    "`product` and `company` holding the outputs at product and company level. ",
    "Unnesting `product` yields a data frame with at least columns ",
    at_all_levels, ". Unnesting `company` yields a data frame with at least ",
    "columns ", at_company_level, "."
  )
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
  if (hasName(data, "companies_id")) {
    out <- data
  } else {
    out <- data |> rename(companies_id = aka("id"))
  }

  distinct(out)
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
  stopifnot(is_named(x))
  stopifnot(is.character(expected_names))

  ok <- all(unique(expected_names) %in% names(x))
  if (!ok) {
    abort_missing_names(sort(setdiff(expected_names, names(x))))
  }

  invisible(x)
}

abort_missing_names <- function(missing_names) {
  abort(
    "missing_names",
    message = glue(
      "Must have missing names:
      {paste0('`', missing_names, '`', collapse = ', ')}"
    )
  )
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

polish_output <- function(data, level_cols) {
  na_cols <- setdiff(level_cols, "companies_id")
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

nest_levels <- function(product, company) {
  .by <- "companies_id"
  left_join(
    nest(product, .by = all_of(.by), .key = "product"),
    nest(company, .by = all_of(.by), .key = "company"),
    by = .by
  )
}

check_string_lengh <- function(x, length) {
  label <- deparse(substitute(x))
  if (!all(nchar(x) == length)) {
    abort(glue("All values of `{label}` must have length {length}."))
  }

  invisible(x)
}

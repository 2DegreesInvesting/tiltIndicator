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

empty_output_at_company_level <- function(companies_id, grouped_by) {
  expand_grid(
    companies_id = companies_id,
    grouped_by = grouped_by,
    risk_category = risk_category_levels(),
    value = NA_real_
  )
}

grouped_by <- function(data, grouped_by) {
  if (is_xctr(data)) {
    grouped_by <- flat_benchmarks()
  }
  grouped_by
}

standardize_companies <- function(companies) {
  companies |>
    distinct() |>
    rename(companies_id = "company_id")
}

standardize_co2 <- function(co2) {
  co2 |>
    distinct() |>
    rename(metric = find_co2_metric(co2)) |>
    rename(
      tilt_sec = ends_with("tilt_sector"),
      unit = ends_with("unit"),
      isic_sec = ends_with("isic_4digit")
    )
}

standardize_scenarios <- function(scenarios) {
  scenarios |>
    distinct() |>
    rename(metric = "reductions")
}

lowercase_characters <- function(data) {
  mutate(data, across(where(is.character), tolower))
}

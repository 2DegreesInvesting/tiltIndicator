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
  matches_name(data, col_to_rank(data))
}

get_column <- function(data, pattern) {
  data[[extract_name(data, pattern)]]
}

ptype_at_company_level <- function() {
  structure(
    list(
      companies_id = character(0),
      grouped_by = character(0),
      risk_category = character(0),
      value = numeric(0)
    ),
    row.names = integer(0),
    class = c("tbl_df", "tbl", "data.frame")
  )
}

categorize_risk <- function(x, low_threshold, high_threshold, ...) {
  case_when(
    x <= low_threshold ~ "low",
    x > low_threshold & x <= high_threshold ~ "medium",
    x > high_threshold ~ "high",
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

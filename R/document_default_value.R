#' Document the default return value
#'
#' @keywords internal
#' @export
#' @examples
#' document_default_value()
document_default_value <- function() {
  at_all_levels <- toString(paste0("`", cols_at_all_levels(), "`"))
  at_company_level <- toString(paste0("`", cols_at_company_level(), "`"))

  paste0(
    document_tilt_profile(),
    " Unnesting `product` yields a data frame with at least columns ",
    at_all_levels, ". Unnesting `company` yields a data frame with at least ",
    "columns ", at_company_level, "."
  )
}

document_dataset <- function() {
  paste0(
    "A dataframe like the dataset with a matching name in tiltToyData (see ",
    "[Reference](https://2degreesinvesting.github.io/tiltToyData/reference/index.html))"
  )
}

document_value <- function() {
  paste0(document_default_value(), " ", document_optional_rowid())
}

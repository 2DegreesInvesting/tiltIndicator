#' @examples
#' grepl(id_pattern(), "companies_id")
#' grepl(id_pattern(), "company_id")
#' @noRd
id_pattern <- function() {
  "^compan.*_id$"
}

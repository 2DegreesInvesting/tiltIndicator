sanitize_id <- function(data) {
  if (hasName(data, "companies_id")) {
    out <- data
  } else {
    out <- data |> rename(companies_id = company_id)
  }
  out
}

#' @examples
#' grepl(id_pattern(), "companies_id")
#' grepl(id_pattern(), "company_id")
#' @noRd
id_pattern <- function() {
  "^compan.*_id$"
}

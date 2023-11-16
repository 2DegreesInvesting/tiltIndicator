sanitize_id <- function(data, quiet = FALSE) {
  if (hasName(data, "companies_id")) {
    out <- data
  } else {
    if (!quiet) {
      rlang::warn(c(
        "Renaming from `company_id` to `companies_id`.",
        i = "Are you using outdated data?"
      ), class = "sanitize_id")
    }
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

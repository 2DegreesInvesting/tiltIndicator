sanitize_id <- function(data, quiet = FALSE) {
  if (hasName(data, "companies_id")) {
    out <- data
  } else {
    out <- rename_id(data, quiet)
  }

  out
}

rename_id <- function(data, quiet = FALSE) {
  if (!quiet) {
    warn_rename_id()
  }

  rename(data, companies_id = "company_id")
}

warn_rename_id <- function() {
  warn(c(
    "Renaming from `company_id` to `companies_id`.",
    i = "Are you using outdated data?"
  ), class = "rename_id")
}

#' @examples
#' grepl(id_pattern(), "companies_id")
#' grepl(id_pattern(), "company_id")
#' @noRd
id_pattern <- function() {
  "^compan.*_id$"
}

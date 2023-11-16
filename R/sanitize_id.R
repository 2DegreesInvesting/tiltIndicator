sanitize_id <- function(data) {
  if (hasName(data, "companies_id")) {
    out <- data
  } else {
    out <- data |> rename(companies_id = company_id)
  }
  out
}

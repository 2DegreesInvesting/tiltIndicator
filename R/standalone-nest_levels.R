nest_levels <- function(product, company) {
  .by <- "companies_id"
  left_join(
    nest(product, .by = all_of(.by), .key = "product"),
    nest(company, .by = all_of(.by), .key = "company"),
    by = .by
  )
}

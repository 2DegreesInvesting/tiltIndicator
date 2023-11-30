#' Nest levels
#'
#' @keywords internal
#' @export
#' @examples
#' product <- data.frame(companies_id = 1, x = 1)
#' company <- data.frame(companies_id = 1, x = 1)
#' nest_levels(product, company)
nest_levels <- function(product, company) {
  .by <- "companies_id"
  left_join(
    nest(product, .by = all_of(.by), .key = "product"),
    nest(company, .by = all_of(.by), .key = "company"),
    by = .by
  )
}

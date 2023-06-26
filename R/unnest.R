#' Unnest product- and company-level results
#'
#' @param data A nested data frame, e.g. the output of [pstr()].
#'
#' @family helpers
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' companies <- pstr_companies
#' scenarios <- xstr_scenarios
#'
#' both <- pstr(companies, scenarios)
#' both
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()
unnest_product <- function(data) {
  nested <- select(data, -"company")
  unnest(nested, "product")
}

#' @export
#' @rdname unnest_product
unnest_company <- function(data) {
  nested <- select(data, -"product")
  unnest(nested, "company")
}

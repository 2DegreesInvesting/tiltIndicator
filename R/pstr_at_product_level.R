#' Calculate the PCTR at product level
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [pstr_scenarios].
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' pstr_at_product_level(pstr_companies, pstr_scenarios)
pstr_at_product_level <- function(companies, scenarios) {
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk()
}

#' Add the emission reduction targets to the companies dataset
#'
#' @examples
#' scenarios <- pstr_scenarios
#' companies <- pstr_companies
#' pstr_add_reductions(companies, scenarios)
#' @noRd
pstr_add_reductions <- function(companies, scenarios) {
  left_join(
    companies, scenarios,
    by = join_by(type, sector, subsector),
    relationship = "many-to-many"
  )
}


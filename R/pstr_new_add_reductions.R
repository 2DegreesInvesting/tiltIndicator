#' Add the emission reduction targets to the companies dataset
#'
#' Adds the emission reduction values for each company's product(s).
#'
#' @param companies TODO
#' @param scenario TODO
#'
#' @family PSTR functions
#'
#' @return
#' A dataframe with:
#'   * All the columns from the `companies` dataset.
#'   * New columns:
#'       * All the columns from the `scenario` dataset.
#' @export
#'
#' @examples
#' scenarios <- pstr_scenarios
#' companies <- pstr_companies
#' pstr_new_add_reductions(companies, scenarios)
pstr_new_add_reductions <- function(companies, scenarios) {
  left_join(
    companies, scenarios,
    by = join_by(type, sector, subsector),
    relationship = "many-to-many"
  )
}

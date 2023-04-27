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
#' library(dplyr, warn.conflicts = FALSE)
#' weo <- slice(pstr_new_weo_2022, 1)
#' ipr <- slice(pstr_new_ipr_2022, 1)
#' scenarios <- pstr_prepare_scenario(list(weo = weo, ipr = ipr))
#' companies <- pstr_prepare_companies(slice(pstr_new_companies, 1))
#' pstr_new_add_reductions(companies, scenarios)
pstr_new_add_reductions <- function(companies, scenarios) {
  left_join(
    companies, scenarios,
    by = join_by(type, sector, subsector),
    relationship = "many-to-many"
  )
}

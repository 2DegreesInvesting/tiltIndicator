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
#' @keywords internal
#'
#' @examples
pstr_new_add_reductions <- function(companies, scenario) {
  left_join(
    companies, scenario,
    by = join_by(type, sector, subsector),
    relationship = "many-to-many"
  )
}

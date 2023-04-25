#' Add the emission reduction targets to the companies dataset
#'
#' Adds the emission reduction values for each company's product(s).
#'
#' TODO : rename pstr_new_companies into pstr_companies once done with
#' the new data set. Should scenario be named pstr_scenario ?
#'
#' @param companies A [data.frame] like [pstr_new_companies].
#' @param scenario A [data.frame] like [pstr_scenario].
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
#' TODO
pstr_new_add_reductions <- function(companies, scenario) {
  left_join(
    companies, scenario,
    by = join_by(type, sector, subsector),
    relationship = "many-to-many"
  )
}

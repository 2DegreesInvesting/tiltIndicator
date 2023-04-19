#' Join the Ecoinvent's' sectors and the WEO 2022 file on the sectors by use the mapper that serves as a sector classification bridge between.
#'
#'
#' @param companies A [data.frame] like [istr_companies].
#' @param ep_weo A [data.frame] like [istr_ep_weo].
#'
#' @family ISTR functions
#'
#' @return A dataframe with:
#'   * All the columns from the `companies` dataset.
#'   * New columns:
#'       * All the columns from the `ep_weo` dataset, but the columns
#'       `eco_sectors` is named `ECO_sector` respectively.
#'
#' @export
#'
#' @examples
#' istr_companies |>
#'   istr_mapping(istr_ep_weo) |>
#'   istr_add_reductions(istr_weo_2022)
istr_mapping <- function(companies, ep_weo) {
  companies |>
    left_join(ep_weo, by = c("eco_sectors" = "ECO_sector"))
}

#' Add the emission reduction targets to the companies dataset
#'
#' Adds the emission reduction values for each company's product(s).
#'
#' @author Linda Delacombaz.
#'
#' @param companies A [data.frame] like [pstr_old_companies].
#' @param ep_weo A [data.frame] like [pstr_ep_weo].
#' @param weo_2022 A [data.frame] like [pstr_weo_2022].
#'
#' @family PSTR functions
#'
#' @return A dataframe with:
#'   * All the columns from the `companies` dataset.
#'   * New columns:
#'       * All the columns from the `ep_weo` dataset, but the columns
#'       `EP_sector` and `EP_subsector` are named `sector` and `subsector`
#'       respectively.
#'
#' @export
#' @keywords internal
#'
#' @examples
#' pstr_old_companies |>
#'   pstr_old_add_reductions(pstr_ep_weo, pstr_weo_2022)
pstr_old_add_reductions <- function(companies, ep_weo, weo_2022) {
  companies |>
    left_join(ep_weo, by = c("sector" = "EP_sector", "subsector" = "EP_subsector")) |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

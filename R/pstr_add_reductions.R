#' Add the emission reduction targets to the companies dataset
#'
#' @param companies A `companies` dataframe like [`companies`].
#' @param ep_weo A `ep_weo` dataframe like [`ep_weo`].
#' @param weo_2022 A `weo_2022` dataframe like [`weo_2022`].
#'
#' @return A dataframe with:
#'   * All the columns from the `companies` dataset.
#'   * New columns :
#'       * All the columns from the `ep_weo` dataset, but the columns
#'       `EP_sector` and `EP_subsector` are named `sector` and `subsector`
#'       respectively.
#'       * All the columns from the `weo_2022` dataset, but the columns
#'       `weo_product_mapper` and `weo_flow_mapper` are named `product` and
#'       `flow`, respectively.
#'
#' @export
#'
#' @examples
#' companies |>
#'   pstr_add_reductions(ep_weo, weo_2022)
pstr_add_reductions <- function(companies, ep_weo, weo_2022) {
  companies |>
    left_join(ep_weo, by = c("sector" = "EP_sector", "subsector" = "EP_subsector")) |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

#' Add the emission reduction targets to the companies dataset
#'
#' Adds the emission reduction values for each company's product(s).
#'
#' @author Lyanne Ho.
#'
#' @param companies A [data.frame] like [istr_companies].
#' @param weo_2022 A [data.frame] like [istr_weo_2022].
#'
#' @family ISTR functions
#'
#' @return A dataframe with:
#'   * All the columns from the `companies` dataset.
#'   * New columns:
#'       * All the columns from the `ep_weo` dataset, but the columns
#'       `eco_sectors` is named `ECO_sector` respectively.
#'       * All the columns from the `weo_2022` dataset, but the columns
#'       `weo_product_mapper` and `weo_flow_mapper` are named `product` and
#'       `flow`, respectively.
#'
#' @export
#'
#' @examples
#' istr_companies |>
#'   istr_mapping(istr_ep_weo) |>
#'   istr_add_reductions(istr_weo_2022)
istr_add_reductions <- function(companies, weo_2022) {
  companies |>
    #left_join(ep_weo, by = c("eco_sectors" = "ECO_sector")) |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

#' Categorize sector emission reduction targets
#'
#' `pstr_add_transition_risk()` translates the `reductions` column into three categories :
#' * "low" if `reductions` <= 30.0
#' * "medium" if 30.0 < `reductions` <= 70.0
#' * "high" if `reductions` > 70.0
#'
#' @param with_reductions A data frame. The output of [pstr_add_reductions()].
#'
#' @return A data frame with:
#'    * All the columns from the `companies` dataset.
#'    * All the columns from the `ep_weo` dataset, but the columns
#'    `EP_sector` and `EP_subsector` are named `sector` and `subsector`
#'    respectively.
#'    * All the columns from the `weo_2022`dataset, but the columns
#'    `weo_product_mapper` and `weo_flow_mapper` are named `product` and
#'    `flow`, respectively.
#'    * New column :
#'       * `transition_risk` that holds the categorization of the `reductions`
#'       column.
#'
#' @export
#'
#' @examples
#' companies |>
#'   pstr_add_reductions(ep_weo, weo_2022) |>
#'   pstr_add_transition_risk()
pstr_add_transition_risk <- function(with_reductions) {
  with_reductions |>
    mutate(
      transition_risk = case_when(
        reductions <= 30 ~ "low",
        reductions > 30 & reductions <= 70 ~ "medium",
        reductions >= 70 ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

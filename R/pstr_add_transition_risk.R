#' Categorizes sector emission reduction targets into high, medium, and low
#' product sector transition risk.
#'
#' @param with_reductions A data frame. The output of [pstr_add_reductions()].
#'
#' @return A data frame with:
#'    * All the columns from the `companies` dataset.
#'    * All the columns from the `ep_weo` dataset.
#'    * All the columns from the `weo_2022`dataset.
#'    * New column :
#'       * `transtion_risk` that holds the categorization of the `reductions`
#'       column.
#'
#' @export
#'
#' @examples
#' # TODO
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

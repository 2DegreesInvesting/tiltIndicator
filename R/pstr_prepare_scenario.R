#' Prepare the scenario data set
#'
#' @param ipr A [data.frame] like [pstr_ipr_2022].
#' @param weo A [data.frame] like [pstr_weo_2022].
#'
#' @return A dataframe with:
#'   * All the columns from the `ipr` dataset.
#'   * New columns:
#'       * All the columns from the `weo` dataset.
#' @export
#'
#' @examples
pstr_prepare_scenario <- function(ipr, weo) {
  bind_rows(
    pstr_prepare_scenario_impl(ipr, "ipr"),
    pstr_prepare_scenario_impl(weo, "weo")
  )
}
#' Title
#'
#' TODO
#' @param data
#' @param type
#'
#' @return
#'
#' @noRd
#'
#' @examples
pstr_prepare_scenario_impl <- function(data, type) {
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = co2_reductions)
}

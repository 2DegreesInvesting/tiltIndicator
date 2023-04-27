#' Prepare the scenario data set
#'
#' @param ipr TODO
#' @param weo TODO
#'
#' @family PSTR functions
#'
#' @return A dataframe with:
#'   * All the columns from the `ipr` dataset.
#'   * All the columns from the `weo` dataset.
#' @export
#'
#' @keywords internal
#'
#' @examples # TODO
pstr_prepare_scenario <- function(ipr, weo) {
  bind_rows(
    pstr_prepare_scenario_impl(ipr, "ipr"),
    pstr_prepare_scenario_impl(weo, "weo")
  )
}

pstr_prepare_scenario_impl <- function(data, type) {
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = "co2_reductions")
}

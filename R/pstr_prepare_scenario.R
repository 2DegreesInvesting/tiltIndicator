#' Prepare the scenario data set
#'
#' @param ipr TODO
#' @param weo TODO
#'
#' @family PSTR functions
#'
#' @return A dataframe with a cleaner, row-bind version of all scenarios with an
#'   additinal column identifying which rows come from which scenario.
#' @noRd
pstr_prepare_scenario <- function(scenarios) {
  imap_dfr(scenarios, ~ pstr_prepare_scenario_impl(.x, .y))
}

pstr_prepare_scenario_impl <- function(data, type) {
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = "co2_reductions")
}

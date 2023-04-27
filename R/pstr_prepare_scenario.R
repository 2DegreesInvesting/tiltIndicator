#' Given a named list of scenarios returns a single, cleaner dataframe
#'
#' @param scenarios A named list of identically structured scenarios.
#'
#' @return A single, cleaner dataframe with an additinal column identifying
#'   which rows come from which scenario.
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

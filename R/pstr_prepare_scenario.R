#' Given a named list of scenarios returns a cleaner `scenarios` dataframe
#'
#' @param scenarios A named list of identically structured scenarios.
#'
#' @family pre-processing helpers
#'
#' @return A single, cleaner dataframe with an additional column to identify
#'   which rows come from which scenario.
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' weo <- slice(pstr_new_weo_2022, 1:2)
#' ipr <- slice(pstr_new_weo_2022, 1:2)
#'
#' scenarios <- list(weo = weo, ipr = ipr)
#' pstr_prepare_scenario(scenarios)
#'
#' # You prepare other scenarios
#' scenarios <- list(scen1 = weo, scen2 = weo)
#' pstr_prepare_scenario(scenarios) |>
#'   relocate(type)
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

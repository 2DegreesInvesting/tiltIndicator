#' Given a named list of scenarios returns a cleaner `scenarios` dataframe
#'
#' @param scenarios A named list of identically structured scenarios.
#'
#' @family pre-processing helpers
#'
#' @return A single, cleaner dataframe with an additional column to identify
#'   which rows come from which scenario.
#'
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' library(readr, warn.conflicts = FALSE)
#'
#' raw_weo <- read_csv(extdata_path("pstr_weo_2022.csv"))
#' raw_ipr <- read_csv(extdata_path("pstr_ipr_2022.csv"))
#' raw_scenarios <- list(weo = raw_weo, ipr = raw_ipr)
#'
#' pstr_prepare_scenario(raw_scenarios)
pstr_prepare_scenario <- function(scenarios) {
  # Hack #308
  if (hasName(scenarios, "weo")) {
    scenarios$weo <- rename(
      scenarios$weo,
      weo_sector = "weo_product",
      weo_subsector = "weo_flow"
    )
  }

  imap_dfr(scenarios, ~ pstr_prepare_scenario_impl(.x, .y))
}

pstr_prepare_scenario_impl <- function(data, type) {
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = "co2_reductions")
}

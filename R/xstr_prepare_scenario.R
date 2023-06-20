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
#' raw_weo <- read_csv(extdata_path("str_weo_targets.csv"))
#' raw_ipr <- read_csv(extdata_path("str_ipr_targets.csv"))
#' raw_scenarios <- list(weo = raw_weo, ipr = raw_ipr)
#'
#' xstr_prepare_scenario(raw_scenarios)
xstr_prepare_scenario <- function(scenarios) {
  map_dfr(scenarios, xstr_prepare_scenario_impl)
}

xstr_prepare_scenario_impl <- function(data) {
  abort_if_duplicated_cols(data, quos("scenario", "year", ends_with("sector")))

  type <- extract_scenario_type(data)
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = "co2_reductions")
}

extract_scenario_type <- function(data) {
  types <- grep("sector", names(data), value = TRUE)
  unique(unlist(lapply(strsplit(types, "_"), "[[", 1)))
}

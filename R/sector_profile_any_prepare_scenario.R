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
#' raw_weo <- read_csv(extdata_path("raw_sector_profile_any_weo_targets.csv"))
#' raw_ipr <- read_csv(extdata_path("raw_sector_profile_any_ipr_targets.csv"))
#' raw_scenarios <- list(weo = raw_weo, ipr = raw_ipr)
#'
#' sector_profile_any_prepare_scenario(raw_scenarios)
sector_profile_any_prepare_scenario <- function(scenarios) {
  map_dfr(scenarios, sector_profile_any_prepare_scenario_impl)
}

sector_profile_any_prepare_scenario_impl <- function(data) {
  data |>
    select(aka("scenario_name"), aka("xyear"), ends_with(aka("xsector"))) |>
    abort_if_duplicated()

  type <- extract_scenario_type(data)
  data |>
    lowercase_characters() |>
    rename_with(~ gsub(paste0(type, "_"), "", .x)) |>
    mutate(type = type) |>
    rename(reductions = "co2_reductions")
}

extract_scenario_type <- function(data) {
  types <- grep(aka("xsector"), names(data), value = TRUE)
  unique(unlist(lapply(strsplit(types, "_"), "[[", 1)))
}

hint_needs_prep <- function() {
  "Did you need to prepare the data with `sector_profile_any_prepare_scenario()`?"
}

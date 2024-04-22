#' Renamed functions and datasets
#'
#' @description
#' `r lifecycle::badge('deprecated')`
#'
#' Conceptual changes:
#' * PCTR becomes Emissions Profile.
#' * ICTR becomes Emissions Profile Upstream.
#' * PSTR becomes Sector Profile.
#' * ISTR becomes Sector Profile Upstream.
#'
#' Motivation:
#' * The names are more informative and easier to remember.
#' * All indicators now share only one common word (profile) instead of two
#' (transition risk).
#' * The word "upstream" is more familiar for users in banks than "inputs".
#' * The word "emissions" replaces "carbon" because the data that we use actually
#' take into account CO2 equivalents, i.e. all green house gasses.
#' * Compared to the phrase "transition risk", the word "tilt_profile" better reflects
#' that the indicators cannot only be used for risk assessment but also for
#' other things, such as broader sustainability assessment, engagement,
#' reporting, etc.
#'
#' Implementation changes:
#' * v0.0.0.9084: `pstr()` -> `sector_profile()`
#' * v0.0.0.9085: `istr()` -> `sector_profile_upstream()`
#' * v0.0.0.9086: `xctr(companies, products)` -> `emissions_profile()`
#' * v0.0.0.9087: `xctr(companies, inputs)` -> `emissions_profile_upstream()`
#' * v0.0.0.9089: All datasets names match the functions above and moved to [tiltToyData](https://2degreesinvesting.github.io/tiltToyData/reference/index.html)
#' * v0.0.0.9092: `xstr_pivot_type_sector_subsector()` -> `sector_profile_any_pivot_type_sector_subsector()`
#' * v0.0.0.9092: `xstr_prepare_scenario()` -> `sector_profile_any_prepare_scenario()`
#' * v0.0.0.9092: `xstr_prune_companies()` -> `sector_profile_any_prune_companies()`
#' * v0.0.0.9092: `xstr_polish_output_at_company_level()` -> `sector_profile_any_polish_output_at_company_level()`
#' @keywords internal
#' @name rename
#' @aliases NULL
NULL

#' @export
#' @rdname rename
pstr <- function(companies,
                 scenarios,
                 low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                 high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  lifecycle::deprecate_stop("0.0.0.9084", "pstr()", "sector_profile()")
}

#' @export
#' @rdname rename
istr <- function(companies,
                 scenarios,
                 inputs,
                 low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                 high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  lifecycle::deprecate_stop("0.0.0.9085", "istr()", "sector_profile_upstream()")
}

#' @export
#' @rdname rename
xctr <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  lifecycle::deprecate_stop("0.0.0.9086", "xctr()", "emissions_profile()")
}

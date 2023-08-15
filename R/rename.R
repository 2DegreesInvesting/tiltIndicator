#' Functions and datasets renamed in tiltIndicator 0.0.1
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
#' take into account CO2 equivalents, i.e. all GHG.
#' * Compared to the phrase "transition risk", the word "profile" better reflects
#' that the indicators cannot only be used for risk assessment but also for
#' other things, such as broader sustainability assessment, engagement,
#' reporting, etc.
#'
#' Implementation changes:
#' * `pstr()` -> `sector_profile()`
#'
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
  lifecycle::deprecate_warn("0.0.1", "pstr()", "sector_profile()")

  sector_profile(
    companies = companies,
    scenarios = scenarios,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )
}

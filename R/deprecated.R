#' Deprecated
#'
#' @description
#' `r lifecycle::badge('deprecated')`
#'
#' All functions of the form `f_at_product_level()` and `f_at_company_level()`
#' are now deprecated in favor of higher-level wrappers (see
#' `?tiltIndicator::rename`).
#'
#' @keywords internal
#' @name deprecated
#' @aliases NULL
NULL

#' @export
#' @rdname deprecated
istr_at_product_level <- function(companies,
                                  scenarios,
                                  inputs,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  lifecycle::deprecate_stop("0.0.0.9088", "istr_at_product_level()")
}

#' @export
#' @rdname deprecated
pstr_at_product_level <- function(companies,
                                  scenarios,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  lifecycle::deprecate_stop("0.0.0.9088", "pstr_at_product_level()")
}

#' @export
#' @rdname deprecated
xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  lifecycle::deprecate_stop("0.0.0.9088", "xctr_at_product_level()")
}

#' @export
#' @rdname deprecated
istr_at_company_level <- function(data) {
  lifecycle::deprecate_stop("0.0.0.9088", "istr_at_company_level()")
}

#' @rdname deprecated
#' @export
pstr_at_company_level <- function(data) {
  lifecycle::deprecate_stop("0.0.0.9088", "pstr_at_company_level()")
}

#' @export
#' @rdname deprecated
xctr_at_company_level <- function(data) {
  lifecycle::deprecate_stop("0.0.0.9088", "xctr_at_company_level()")
}

#' @export
#' @rdname deprecated
xstr_pivot_type_sector_subsector <- function(data) {
  lifecycle::deprecate_stop(
    "0.0.0.9092",
    what = "xstr_pivot_type_sector_subsector()",
    with = "sector_profile_any_pivot_type_sector_subsector()"
  )
}

#' @export
#' @rdname deprecated
xstr_prepare_scenario <- function(scenarios) {
  lifecycle::deprecate_stop(
    "0.0.0.9092",
    what = "xstr_prepare_scenario()",
    with = "sector_profile_any_prepare_scenario()"
  )
}

#' @export
#' @rdname deprecated
xstr_prune_companies <- function(data) {
  lifecycle::deprecate_stop(
    "0.0.0.9092",
    what = "xstr_prune_companies()",
    with = "sector_profile_any_prune_companies()"
  )
}

#' @export
#' @rdname deprecated
xstr_polish_output_at_company_level <- function(data) {
  lifecycle::deprecate_stop(
    "0.0.0.9092",
    what = "xstr_polish_output_at_company_level()",
    with = "sector_profile_any_polish_output_at_company_level()"
  )
}

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
  deprecate_warn("0.0.0.9088", "istr_at_product_level()")
  sector_profile_upstream_at_product_level(
    companies = companies,
    scenarios = scenarios,
    inputs = inputs,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )
}

#' @export
#' @rdname deprecated
pstr_at_product_level <- function(companies,
                                  scenarios,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  deprecate_warn("0.0.0.9088", "pstr_at_product_level()")
  sector_profile_at_product_level(
    companies = companies,
    scenarios = scenarios,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )
}

#' @export
#' @rdname deprecated
xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  deprecate_warn("0.0.0.9088", "xctr_at_product_level()")
  emissions_profile_any_at_product_level(
    companies = companies,
    co2 = co2,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )
}

#' @export
#' @rdname deprecated
istr_at_company_level <- function(data) {
  deprecate_warn("0.0.0.9088", "istr_at_company_level()")
  any_at_company_level(data)
}

#' @rdname deprecated
#' @export
pstr_at_company_level <- function(data) {
  deprecate_warn("0.0.0.9088", "pstr_at_company_level()")
  any_at_company_level(data)
}

#' @export
#' @rdname deprecated
xctr_at_company_level <- function(data) {
  deprecate_warn("0.0.0.9088", "xctr_at_company_level()")
  any_at_company_level(data)
}

#' @export
#' @rdname deprecated
xstr_pivot_type_sector_subsector <- function(data) {
  deprecate_warn(
    "0.0.0.9092",
    what = "xstr_pivot_type_sector_subsector()",
    with = "sector_profile_any_pivot_type_sector_subsector()"
  )
  sector_profile_any_pivot_type_sector_subsector(data)
}

#' @export
#' @rdname deprecated
xstr_prepare_scenario <- function(scenarios) {
  deprecate_warn(
    "0.0.0.9092",
    what = "xstr_prepare_scenario()",
    with = "sector_profile_any_prepare_scenario()"
  )
  sector_profile_any_prepare_scenario(scenarios)
}

#' @export
#' @rdname deprecated
xstr_prune_companies <- function(data) {
  deprecate_warn(
    "0.0.0.9092",
    what = "xstr_prune_companies()",
    with = "sector_profile_any_prune_companies()"
  )
  sector_profile_any_prune_companies(data)
}

#' @export
#' @rdname deprecated
xstr_polish_output_at_company_level <- function(data) {
  deprecate_warn(
    "0.0.0.9092",
    what = "xstr_polish_output_at_company_level()",
    with = "sector_profile_any_polish_output_at_company_level()"
  )
  sector_profile_any_polish_output_at_company_level(data)
}

#' Avoid R CMD Check warning about undocumented data sets
#'
#' R CMD check wants documentation for anything defined in this file. I stick
#' all objects in `e` so that I can document that single `e` object as internal.
#' @keywords internal
#' @name e
"e"

#' @rdname deprecated
"companies"

#' @rdname deprecated
"inputs"

#' @rdname deprecated
"products"

#' @rdname deprecated
"istr_companies"

#' @rdname deprecated
"istr_inputs"

#' @rdname deprecated
"pstr_companies"

#' @rdname deprecated
"xstr_scenarios"

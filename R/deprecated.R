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
  istr_product(
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
  pstr_product(
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
  xctr_product(
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
  xctr_company(data)
}

#' @rdname deprecated
#' @export
pstr_at_company_level <- function(data) {
  deprecate_warn("0.0.0.9088", "pstr_at_company_level()")
  xctr_company(data)
}

#' @export
#' @rdname deprecated
xctr_at_company_level <- function(data) {
  deprecate_warn("0.0.0.9088", "xctr_at_company_level()")
  xctr_company(data)
}

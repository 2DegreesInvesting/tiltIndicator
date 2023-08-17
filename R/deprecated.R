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

warn_product_and_company_level_functions_are_now_deprecated <- function() {
  if (!is_testing()) {
    warn(c(
      "`*at_company_level()` and `*at_product_level()` are now deprecated.",
      i = "Instead use `emissions_profle()`, `sector_profile()`, etc."
    ))
  }
}

#' @export
#' @rdname deprecated
pstr_at_product_level <- function(companies,
                                  scenarios,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  warn_product_and_company_level_functions_are_now_deprecated()

  pstr_product(
    companies = companies,
    scenarios = scenarios,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )
}

#' @export
#' @rdname deprecated
istr_at_product_level <- function(companies,
                                  scenarios,
                                  inputs,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  warn_product_and_company_level_functions_are_now_deprecated()

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
xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  warn_product_and_company_level_functions_are_now_deprecated()
  xctr_product(
    companies = companies,
    co2 = co2,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )
}

#' @export
#' @rdname deprecated
xctr_at_company_level <- function(data) {
  warn_product_and_company_level_functions_are_now_deprecated()

  xctr_company(data)
}

#' @rdname deprecated
#' @export
pstr_at_company_level <- function(data) {
  warn_product_and_company_level_functions_are_now_deprecated()

  xctr_company(data)
}
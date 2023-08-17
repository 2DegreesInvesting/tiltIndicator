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

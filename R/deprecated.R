#' Deprecated
#'
#' @description
#' `r lifecycle::badge('deprecated')`
#'
#' All functions of the form `f_at_product_level()` or `f_at_company_level()`
#' are now deprecated in favour of a function of the form `f()`.
#'
#' @keywords internal
#' @name deprecated
#' @aliases NULL
NULL

warn_product_and_company_level_functions_are_now_deprecated <- function() {
  if (!is_testing()) {
    warn(c(
      "All functions at product and company level are now internal.",
      i = "Use the top level wrapper instead."
    ))
  }
}

#' Calculate the PSTR indicator
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function was deprecated because its name is terse and it doesn't help
#' access results at product level.
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [xstr_scenarios].
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' library(dplyr)
#' library(tidyr)
#'
#' companies <- pstr_companies
#' scenarios <- xstr_scenarios
#'
#' # Deprecated
#' company_level <- pstr(companies, scenarios)
#' company_level
#'
#' # Now
#' both <- product_sector(companies, scenarios)
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()
#' @keywords internal
pstr <- function(companies,
                 scenarios,
                 low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                 high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  lifecycle::deprecate_warn(
    when = "0.0.0.9076",
    what = "pstr()",
    with = "product_sector()"
  )
  companies |>
    pstr_at_product_level(scenarios, low_threshold, high_threshold) |>
    xctr_at_company_level()
}

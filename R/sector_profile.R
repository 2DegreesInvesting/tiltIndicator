#' Calculate the PSTR indicator
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
#' @inheritParams xctr
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' library(tidyr)
#'
#' companies <- pstr_companies
#' scenarios <- xstr_scenarios
#'
#' # Product level
#' companies |>
#'   pstr_at_product_level(scenarios)
#'
#' # Company level
#' companies |>
#'   pstr_at_product_level(scenarios) |>
#'   pstr_at_company_level()
#'
#' # Or
#' both <- sector_profile(companies, scenarios)
#' both
#'
#' # Product level
#' both |> unnest_product()
#'
#' # Company level
#' both |> unnest_company()
pstr <- function(companies,
                 scenarios,
                 low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                 high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- pstr_at_product_level(companies, scenarios, low_threshold, high_threshold)
  company <- xctr_at_company_level(product)
  nest_levels(product, company)
}
#' @export
#' @rdname pstr
sector_profile <- pstr

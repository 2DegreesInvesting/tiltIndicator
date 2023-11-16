#' Calculate the indicator "sector profile"
#'
#' ```{r child=extdata_path("child/intro-sector-profile.Rmd")}
#' ```
#'
#' @param companies,scenarios `r document_dataset()`.
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' ```{r child=extdata_path("child/example-sector-profile.Rmd")}
#' ```
sector_profile <- function(companies,
                           scenarios,
                           low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                           high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- sector_profile_at_product_level(companies, scenarios, low_threshold, high_threshold)
  company <- any_at_company_level(product)
  nest_levels(product, company)
}

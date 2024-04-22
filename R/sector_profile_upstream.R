#' Calculate the indicator "sector profile upstream"
#'
#' ```{r child=extdata_path("child/intro-sector_profile_upstream.Rmd")}
#' ```
#'
#' @param companies,scenarios,inputs `r document_dataset()`.
#' @inheritParams emissions_profile
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @template example-sector_profile_upstream
sector_profile_upstream <- function(companies,
                                    scenarios,
                                    inputs,
                                    low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                    high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- companies |>
    sector_profile_upstream_at_product_level(scenarios, inputs, low_threshold, high_threshold)
  company <- epa_at_company_level(product) |>
    insert_row_with_na_in_risk_category()

  profile(nest_levels(product, company))
}

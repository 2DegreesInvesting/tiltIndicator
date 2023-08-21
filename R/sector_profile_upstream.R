#' Calculate the indicator "sector profile upstream"
#'
#' ```{r child=extdata_path("child/intro-sector-profile-upstream.Rmd")}
#' ```
#'
#' @param companies `r document_dataset()`.
#' @param scenarios `r document_dataset()`.
#' @param inputs `r document_dataset()`.
#' @inheritParams emissions_profile
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' library(tiltToyData)
#' library(readr)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_sector_profile_upstream_companies())
#' scenarios <- read_csv(toy_sector_profile_any_scenarios())
#' products_upstream <- read_csv(toy_sector_profile_upstream_products())
#'
#' both <- sector_profile_upstream(companies, scenarios, products_upstream)
#' both
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()
sector_profile_upstream <- function(companies,
                                    scenarios,
                                    inputs,
                                    low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                    high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- companies |>
    sector_profile_upstream_at_product_level(scenarios, inputs, low_threshold, high_threshold)
  company <- any_at_company_level(product)
  nest_levels(product, company)
}

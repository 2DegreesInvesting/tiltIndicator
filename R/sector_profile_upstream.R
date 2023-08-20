#' Calculate the indicator "sector profile upstream"
#'
#' ```{r child=extdata_path("child/intro-sector-profile-upstream.Rmd")}
#' ```
#'
#' @param companies A dataframe like [istr_companies].
#' @param scenarios A dataframe like [xstr_scenarios].
#' @param inputs A dataframe like [istr_inputs].
#' @inheritParams emissions_profile
#'
#' @family sector functions
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
#' companies <- read_csv(toy_path("sector_profile_upstream_companies.csv.gz"))
#' scenarios <- read_csv(toy_path("sector_profile_any_scenarios.csv.gz"))
#' products_upstream <- read_csv(toy_path("sector_profile_upstream_products.csv.gz"))
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

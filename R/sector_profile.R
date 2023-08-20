#' Calculate the indicator "sector profile"
#'
#' ```{r child=extdata_path("child/intro-sector-profile.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [xstr_scenarios].
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
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
#' companies <- read_csv(toy_path("sector_profile_companies.csv.gz"))
#' scenarios <- read_csv(toy_path("sector_profile_any_scenarios.csv.gz"))
#'
#' both <- sector_profile(companies, scenarios)
#' both
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()
sector_profile <- function(companies,
                           scenarios,
                           low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                           high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- sector_profile_at_product_level(companies, scenarios, low_threshold, high_threshold)
  company <- any_at_company_level(product)
  nest_levels(product, company)
}

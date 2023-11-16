#' Calculate the indicator "emissions profile"
#'
#' ```{r child=extdata_path("child/intro-emissions-profile.Rmd")}
#' ```
#'
#' @param companies,co2 `r document_dataset()`.
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' ```{r child=extdata_path("child/example-emissions-profile.Rmd")}
#' ```
emissions_profile <- function(companies,
                              co2,
                              low_threshold = 1 / 3,
                              high_threshold = 2 / 3) {
  product <- emissions_profile_any_at_product_level(companies, co2, low_threshold, high_threshold)
  company <- any_at_company_level(product)
  nest_levels(product, company)
}

#' @export
#' @rdname emissions_profile_upstream
emissions_profile_upstream <- emissions_profile

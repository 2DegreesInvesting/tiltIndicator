#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [pstr_scenarios].
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @example
#' companies <- pstr_companies
#' scenarios <- pstr_scenarios
#' pstr(companies, scenarios)
pstr <- function(companies, scenarios) {
  product_level <- pstr_at_product_level(companies, scenarios)
  company_level <- pstr_at_company_level(product_level, companies)

  company_level |>
    rename(companies_id = "company_id") |>
    xstr_polish_output()
}

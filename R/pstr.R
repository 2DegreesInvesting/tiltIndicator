#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @inheritParams pstr_at_company_level
#' @param scenarios A dataframe with scenario data, e.g. WEO.
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- pstr_companies
#' scenarios <- pstr_scenarios
#' pstr(companies, scenarios)
pstr <- function(companies, scenarios) {
  product_level <- pstr_at_product_level(companies, scenarios)
  company_level <- pstr_at_company_level(product_level, companies)

  company_level |>
    rename(id = "company_id") |>
    relocate_crucial_output_columns() |>
    ungroup()
}

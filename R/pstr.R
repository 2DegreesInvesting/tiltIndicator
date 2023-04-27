#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @inheritParams pstr_old_add_reductions
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
  company_level <- pstr_aggregate_scores(product_level, companies)

  company_level |>
    rename(id = "company_id") |>
    relocate_crucial_output_columns() |>
    ungroup()
}

pstr_at_product_level <- function(companies, scenarios) {
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk()
}

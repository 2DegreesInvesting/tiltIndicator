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
  by_item <- companies |>
    pstr_new_add_reductions(scenarios) |>
    pstr_add_transition_risk()

  by_company <- pstr_aggregate_scores(by_item, companies)

  by_company |>
    rename(id = "company_id") |>
    relocate_crucial_output_columns() |>
    ungroup()
}

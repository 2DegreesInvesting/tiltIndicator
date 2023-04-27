#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @inheritParams pstr_add_reductions
#' @param scenarios A dataframe with scenario data, e.g. WEO.
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' weo <- slice(pstr_new_weo_2022, 1)
#' ipr <- slice(pstr_new_ipr_2022, 1)
#' scenarios <- pstr_prepare_scenario(list(weo = weo, ipr = ipr))
#' companies <- pstr_prepare_companies(slice(pstr_new_companies, 1))
#'
#' pstr(companies, scenarios)
pstr_new <- function(companies, scenarios) {
  by_item <- companies |>
    pstr_new_add_reductions(scenarios) |>
    pstr_add_transition_risk()

  by_company <- pstr_aggregate_scores(by_item, companies)

  by_company |>
    rename(id = "company_id") |>
    relocate_crucial_output_columns() |>
    ungroup()
}

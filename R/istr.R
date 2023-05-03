#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @inheritParams istr_add_reductions
#' @inheritParams istr_aggregate_score
#' @param scenario A dataframe with scenario data.
#' @param mapper A dataframe mapping `companies` to `scenario`.
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' istr(istr_companies, istr_weo_2022, istr_ep_weo)
istr <- function(companies, scenario, mapper) {
  with_reductions <- companies |>
    istr_mapping(mapper) |>
    istr_add_reductions(scenario)

  out <- with_reductions |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(companies)

  out |>
    rename(companies_id = "companies_id") |>
    rename(risk_category = "transition_risk") |>
    relocate_crucial_output_columns() |>
    ungroup()
}

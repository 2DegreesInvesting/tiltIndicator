#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @inheritParams istr_add_reductions
#' @inheritParams istr_aggregate_score
#' @param scenario A dataframe with scenario data.
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' istr(istr_companies, istr_weo_2022, istr_ep_weo)
istr <- function(companies, scenario, mapper = NULL) {
  companies |>
    istr_mapping(mapper) |>
    istr_add_reductions(scenario) |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(companies) |>
    rename(id = "companies_id")
}

#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @inheritParams pstr_add_reductions
#' @inheritParams pstr_aggregate_score
#' @param scenario A dataframe with scenario data, e.g. WEO.
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' pstr(pstr_companies, pstr_weo_2022, pstr_ep_weo)
pstr <- function(companies, scenario, mapper = NULL) {
  with_reductions <- companies |>
    pstr_add_reductions(mapper, scenario)

  with_reductions |>
    pstr_add_transition_risk() |>
    pstr_aggregate_scores(companies) |>
    rename(id = "company_id")
}

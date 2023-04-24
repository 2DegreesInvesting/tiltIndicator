#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @inheritParams pstr_add_reductions
#' @inheritParams pstr_aggregate_score
#'
#' @family PSTR functions
#'
#' @return A dataframe with columns `id`, `transition_risk`, and scores.
#'
#' @export
#'
#' @examples
#' pstr(pstr_companies, pstr_ep_weo, pstr_weo_2022)
pstr <- function(companies, ep_weo, weo_2022) {
  companies |>
    pstr_add_reductions(ep_weo, weo_2022) |>
    pstr_add_transition_risk() |>
    pstr_aggregate_scores(companies) |>
    rename(id = company_id)
}

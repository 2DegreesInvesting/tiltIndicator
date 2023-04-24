#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @inheritParams istr_add_reductions
#' @inheritParams istr_aggregate_score
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' istr(istr_companies, istr_ep_weo, istr_weo_2022)
istr <- function(companies, ep_weo, weo) {
  companies |>
    istr_mapping(ep_weo) |>
    istr_add_reductions(weo) |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(companies) |>
    rename(id = "companies_id")
}

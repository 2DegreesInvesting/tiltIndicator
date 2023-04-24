#' Wrap the ISTR API
#'
#' @inheritParams istr_add_reductions
#' @inheritParams istr_mapping
#'
#' @return A dataframe
#'
#' @examples
#' companies <- istr_toy_companies()
#' ep_weo <- istr_toy_ep_weo()
#' weo <- istr_toy_weo()
#'
#' istr(companies, ep_weo, weo)
#' @noRd
istr <- function(companies, ep_weo, weo) {
  companies |>
    istr_mapping(ep_weo) |>
    istr_add_reductions(weo) |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(companies)
}

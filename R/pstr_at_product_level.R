#' Calculate the PCTR at product level
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [pstr_scenarios].
#'
#' @return A dataframe.
#' @export
#' @keywords internal
#'
#' @examples
#' pstr_at_product_level(pstr_companies, pstr_scenarios)
pstr_at_product_level <- function(companies, scenarios) {
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk()
}

pstr_add_reductions <- function(companies, scenarios) {
  left_join(
    companies, scenarios,
    by = join_by("type", "sector", "subsector"),
    relationship = "many-to-many"
  )
}

pstr_add_transition_risk <- function(with_reductions) {
  with_reductions |>
    mutate(
      transition_risk = case_when(
        reductions <= 30 ~ "low",
        reductions > 30 & reductions <= 70 ~ "medium",
        reductions > 70 ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

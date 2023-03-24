#' Title
#'
#' @param data A data frame. The ouptput of [pstr_add_transition_risk()].
#'
#' @return TODO
#' @export
#'
#' @examples
#' # TODO
pstr_aggregate_scores <- function(data) {
  n_products_per_companies <- companies |>
    group_by(company_name) |>
    summarise(total_products_per_company = n())

  with_transition_risk2 <- data |>
    left_join(n_products_per_companies, by = "company_name")

  with_transition_risk2 |>
    select(company_id, company_name, transition_risk, total_products_per_company, scenario, year) |>
    group_by(company_name, transition_risk, scenario, year) |>
    summarise(score_aggregated = (n() / total_products_per_company * 100), .groups = "keep") |>
    distinct_all()
}


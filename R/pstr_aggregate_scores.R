#' Title
#'
#' @param data A data frame. The output of [pstr_add_transition_risk()].
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
    left_join(
      n_products_per_companies,
      by = "company_name",
      # TODO: ASK Linda to confirm we want this relationship
      relationship = "many-to-many"
    )

  with_transition_risk2 |>
    select(company_id, company_name, transition_risk, total_products_per_company, scenario, year) |>
    group_by(company_name, transition_risk, scenario, year) |>
    reframe(score_aggregated = (n() / total_products_per_company * 100)) |>
    # FIXME? Do we really want grouped output?
    group_by(company_name, transition_risk, scenario, year) |>
    # FIXME: Do we really want distinct_all()? It's superseded by
    # distinct(across(everything() ... and also here it seems we can use just
    # `distinct()`. See ?distinct_all(), ?distinct(), and also this reprex:
    # https://gist.github.com/maurolepore/45c899b9429f5d48004e2e127257cc29
    distinct_all()
}

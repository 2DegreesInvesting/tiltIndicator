#' Aggregate the products' scores for each company
#'
#' Calculates on a company-level the percentage of products that are in low /
#' medium / high transition risk.
#'
#' @param with_transition_risk A data frame. The output of
#'   [pstr_add_transition_risk()].
#' @inheritParams pstr_add_reductions
#'
#' @family PSTR functions
#'
#' @return A data frame with the columns:
#'   * `company_name`
#'   * `transition_risk`
#'   * `scenario`
#'   * `year`
#'   * `score_aggregated`, which holds the aggregated scores in percentage.
#' @export
#'
#' @examples
#' pstr_companies |>
#'   pstr_add_reductions(pstr_ep_weo, pstr_weo_2022) |>
#'   pstr_add_transition_risk() |>
#'   pstr_aggregate_scores(pstr_companies)
pstr_aggregate_scores <- function(with_transition_risk, companies) {
  n_products_per_companies <- companies |>
    group_by(.data$company_name) |>
    summarise(total_products_per_company = n())

  with_transition_risk2 <- with_transition_risk |>
    left_join(
      n_products_per_companies,
      by = "company_name",
      # TODO: ASK Linda to confirm we want this relationship
      relationship = "many-to-many"
    )

  useful_cols <- c(
    "company_id",
    "company_name",
    "transition_risk",
    "total_products_per_company",
    "scenario",
    "year"
  )
  with_transition_risk2 |>
    select(all_of(all_of(useful_cols))) |>
    group_by(.data$company_name, .data$transition_risk, .data$scenario, .data$year) |>
    reframe(score_aggregated = (n() / .data$total_products_per_company * 100)) |>
    # FIXME? Do we really want grouped output?
    group_by(.data$company_name, .data$transition_risk, .data$scenario, .data$year) |>
    # FIXME: Do we really want distinct_all()? It's superseded by
    # distinct(across(everything() ... and also here it seems we can use just
    # `distinct()`. See ?distinct_all(), ?distinct(), and also this reprex:
    # https://gist.github.com/maurolepore/45c899b9429f5d48004e2e127257cc29
    distinct_all()
}

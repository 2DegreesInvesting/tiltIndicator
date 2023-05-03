#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [pstr_scenarios].
#' @param data A dataframe. The output at product level.
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- pstr_companies
#' scenarios <- pstr_scenarios
#'
#' # Product level
#' companies |>
#'   pstr_at_product_level(scenarios)
#'
#' # Company level
#' companies |>
#'   pstr_at_product_level(scenarios) |>
#'   pstr_at_company_level(companies)
#'
#' # Same
#' pstr(companies, scenarios)
pstr <- function(companies, scenarios) {
  companies |>
    pstr_at_product_level(scenarios) |>
    pstr_at_company_level(companies)
}

#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies, scenarios) {
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk()
}

#' @rdname pstr
#' @export
pstr_at_company_level <- function(data, companies) {
  n_products_per_companies <- companies |>
    group_by(.data$company_id, .data$company_name) |>
    summarise(total_products_per_company = n())

  with_transition_risk2 <- data |>
    left_join(
      n_products_per_companies,
      by = c("company_id", "company_name"),
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
  out <- with_transition_risk2 |>
    select(all_of(all_of(useful_cols))) |>
    group_by(.data$company_id, .data$company_name, .data$transition_risk, .data$scenario, .data$year) |>
    reframe(score_aggregated = (n() / .data$total_products_per_company * 100)) |>
    # FIXME? Do we really want grouped output?
    group_by(.data$company_id, .data$company_name, .data$transition_risk, .data$scenario, .data$year) |>
    # FIXME: Do we really want distinct_all()? It's superseded by
    # distinct(across(everything() ... and also here it seems we can use just
    # `distinct()`. See ?distinct_all(), ?distinct(), and also this reprex:
    # https://gist.github.com/maurolepore/45c899b9429f5d48004e2e127257cc29
    distinct_all()

  out |>
    rename(companies_id = "company_id") |>
    xstr_polish_output()
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

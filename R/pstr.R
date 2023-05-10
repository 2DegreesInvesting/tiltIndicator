#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [pstr_scenarios].
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
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
pstr <- function(companies, scenarios, low_threshold = 30, high_threshold = 70) {
  companies |>
    pstr_at_product_level(scenarios, low_threshold, high_threshold) |>
    pstr_at_company_level(companies)
}

#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies, scenarios, low_threshold = 30, high_threshold = 70) {
  check_has_no_na(scenarios, "reductions")

  companies <- rename(companies, companies_id = "company_id")
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk(low_threshold, high_threshold) |>
    xstr_polish_output_at_product_level()
}

#' @rdname pstr
#' @export
pstr_at_company_level <- function(data, companies) {
  .companies <- rename(companies, companies_id = "company_id")
  xstr_at_company_level(data, .companies)
}

xstr_at_company_level <- function(data, companies) {
  return(xctr_at_company_level(data))

  # FIXME: Remove dead code?
  n_products_per_companies <- companies |>
    group_by(.data$companies_id) |>
    summarise(total_products_per_company = n())

  with_risk_category <- data |>
    left_join(
      n_products_per_companies,
      by = c("companies_id"),
      relationship = "many-to-many"
    )

  useful_cols <- c(
    "companies_id",
    "risk_category",
    "total_products_per_company",
    "scenario",
    "year"
  )
  out <- with_risk_category |>
    select(all_of(all_of(useful_cols))) |>
    group_by(.data$companies_id, .data$risk_category, .data$scenario, .data$year) |>
    reframe(score_aggregated = (n() / .data$total_products_per_company)) |>
    group_by(.data$companies_id, .data$risk_category, .data$scenario, .data$year) |>
    distinct() |>
    ungroup()

  xstr_polish_output_at_company_level(out)
}

pstr_add_reductions <- function(companies, scenarios) {
  left_join(
    companies, scenarios,
    by = join_by("type", "sector", "subsector"),
    relationship = "many-to-many"
  )
}

pstr_add_transition_risk <- function(with_reductions, low_threshold, high_threshold) {
  with_reductions |>
    mutate(
      transition_risk = case_when(
        reductions <= low_threshold ~ "low",
        reductions > low_threshold & reductions <= high_threshold ~ "medium",
        reductions > high_threshold ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

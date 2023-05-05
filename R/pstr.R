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
  companies <- rename(companies, companies_id = "company_id")
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk() |>
    xstr_polish_output_at_product_level()
}

#' @rdname pstr
#' @export
pstr_at_company_level <- function(data, companies) {
  companies <- rename(companies, companies_id = "company_id")
  xstr_at_company_level(data, companies)
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
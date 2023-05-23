#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [istr_companies].
#' @param scenarios A dataframe like [istr_scenarios].
#' @param inputs A dataframe like [istr_inputs].
#' @inheritParams xctr
#' @inheritParams pstr
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- istr_companies
#' scenarios <- istr_scenarios
#' inputs <- istr_inputs
#'
#' # Product level
#' companies |>
#'   istr_at_product_level(scenarios, inputs)
#'
#' # Company level
#' companies |>
#'   istr_at_product_level(scenarios, inputs) |>
#'   istr_at_company_level()
#'
#' # Same
#' istr(companies, scenarios, inputs)
istr <- function(companies, scenarios, inputs) {
  companies |>
    istr_at_product_level(scenarios, inputs) |>
    xctr_at_company_level()
}

#' @rdname istr
#' @export
istr_at_product_level <- function(companies,
                                  scenarios,
                                  inputs,
                                  low_threshold = 1 / 3,
                                  high_threshold = 2 / 3) {
  xstr_check(companies, scenarios)

  .scenarios <- standardize_scenarios(scenarios)
  .companies <- standardize_companies(companies)

  inputs |>
    distinct() |>
    istr_add_values_to_categorize(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = "no_sector") |>
    xctr_join_companies(.companies) |>
    xstr_polish_output_at_product_level()
}

# TODO: Remove duplication for mapping
istr_add_values_to_categorize <- function(inputs, scenarios) {
    left_join(
      inputs, scenarios,
      by = join_by("type", "sector", "subsector"),
      relationship = "many-to-many"
    )
}

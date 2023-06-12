#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [istr_companies].
#' @param scenarios A dataframe like [xstr_scenarios].
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
#' scenarios <- xstr_scenarios
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
                                  inputs) {
  xstr_check(companies, scenarios)
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)

  .scenarios <- standardize_scenarios(scenarios)
  .companies <- standardize_companies(companies)

  inputs |>
    distinct() |>
    xstr_add_values_to_categorize(.scenarios) |>
    xstr_add_risk_category(.default = NA) |>
    xctr_join_companies(.companies) |>
    xstr_polish_output_at_product_level() |>
    istr_select_cols_at_product_level()
}

istr_select_cols_at_product_level <- function(data) {
  select(data, all_of(istr_cols_at_product_level()))
}

istr_cols_at_product_level <- function() {
  c(
    xstr_cols_at_product_level(),
    "input_activity_uuid_product_uuid",
    "input_tilt_sector",
    "input_tilt_subsector"
  )
}

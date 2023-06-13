#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [xstr_scenarios].
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
#' @inheritParams xctr
#'
#' @family PSTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- pstr_companies
#' scenarios <- xstr_scenarios
#'
#' # Product level
#' companies |>
#'   pstr_at_product_level(scenarios)
#'
#' # Company level
#' companies |>
#'   pstr_at_product_level(scenarios) |>
#'   pstr_at_company_level()
#'
#' # Same
#' pstr(companies, scenarios)
pstr <- function(companies,
                 scenarios,
                 low_threshold = case_when(scenarios$year == 2030 ~ 1 / 9, .default = 1 / 3),
                 high_threshold = case_when(scenarios$year == 2030 ~ 2 / 9, .default = 2 / 3)) {
  companies |>
    pstr_at_product_level(scenarios, low_threshold, high_threshold) |>
    xctr_at_company_level()
}

#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies,
                                  scenarios,
                                  low_threshold = case_when(scenarios$year == 2030 ~ 1 / 9, .default = 1 / 3),
                                  high_threshold = case_when(scenarios$year == 2030 ~ 2 / 9, .default = 2 / 3)) {
  xstr_check(companies, scenarios)
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)

  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)
  .companies <- prepare_companies(companies)

  .companies |>
    xstr_add_values_to_categorize(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    xstr_polish_output_at_product_level() |>
    pstr_select_cols_at_product_level()
}

xstr_add_values_to_categorize <- function(data, scenarios) {
  left_join(
    data, scenarios,
    by = join_by("type", "sector", "subsector"),
    relationship = "many-to-many"
  )
}

stop_if_all_sector_and_subsector_are_na_for_some_type <- function(scenarios) {
  bad_type <- scenarios |>
    summarize(
      all_na = all(is.na(.data$sector) & is.na(.data$subsector)), .by = "type"
    ) |>
    filter(.data$all_na) |>
    pull(.data$type)

  has_bad_type <- !identical(bad_type, character(0))
  if (has_bad_type) {
    bad <- toString(bad_type)
    abort(c(
      "Each scenario `type` must have some `sector` and `subsector`.",
      x = glue("All `sector` and `subsector` are missing for `type` {bad}."),
      i = "Did you need to prepare the data with `xstr_prepare_scenario()`?"
    ))
  }
  invisible(scenarios)
}

pstr_select_cols_at_product_level <- function(data) {
  select(data, all_of(pstr_cols_at_product_level()))
}

pstr_cols_at_product_level <- function() {
  c(
    xstr_cols_at_product_level(),
    "tilt_subsector"
  )
}

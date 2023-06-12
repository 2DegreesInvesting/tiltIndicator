#' Calculate the PSTR indicator
#'
#' ```{r child=extdata_path("child/intro-pstr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pstr_companies].
#' @param scenarios A dataframe like [xstr_scenarios].
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
pstr <- function(companies, scenarios) {
  companies |>
    pstr_at_product_level(scenarios) |>
    xctr_at_company_level()
}

#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies, scenarios) {
  xstr_check(companies, scenarios)
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)

  .scenarios <- standardize_scenarios(scenarios)
  .companies <- standardize_companies(companies)

  .companies |>
    xstr_add_values_to_categorize(.scenarios) |>
    xstr_add_risk_category(.default = NA) |>
    xstr_polish_output_at_product_level() |>
    pstr_select_cols_at_product_level()
}

# Threshold categories based on years to segment low, medium, and high reduction targets.
threshold_categories <- function(data) {
  case_when(
    data == 2030 ~ list(low = 1/9, high = 2/9),
    .default = list(low = 1/3, high = 2/3)
  )
}

xstr_add_values_to_categorize <- function(data, scenarios) {
  left_join(
    data, scenarios,
    by = join_by("type", "sector", "subsector"),
    relationship = "many-to-many"
  )
}

xstr_add_risk_category <- function(data,
                              ...) {
  lst_of_thresholds <- do.call(rbind, lapply(data$year, threshold_categories))
  mutate(data, risk_category = categorize_risk(
    .data$values_to_categorize, low_threshold = lst_of_thresholds[,1], high_threshold = lst_of_thresholds[,2], ...
  ))
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

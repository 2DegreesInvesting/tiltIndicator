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
#' scenarios <- pstr_scenarios
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
pstr <- function(companies, scenarios, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  companies |>
    pstr_at_product_level(scenarios, low_threshold, high_threshold) |>
    xctr_at_company_level()
}

#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies, scenarios, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  xstr_check(companies, scenarios)
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)

  companies <- rename(companies, companies_id = "company_id")
  out <- companies |>
    pstr_add_reductions(scenarios) |>
    rename(values_to_categorize = "reductions") |>
    add_risk_category(low_threshold, high_threshold) |>
    xstr_polish_output_at_product_level() |>
    select(all_of(pstr_cols_at_product_level()))
  out
}

pstr_cols_at_product_level <- function() {
  c(
    cols_at_product_level(),
    "tilt_sector",
    "tilt_subsector",
    "scenario",
    "year",
    "type"
  )
}

pstr_add_reductions <- function(companies, scenarios) {
  left_join(
    companies, scenarios,
    by = join_by("type", "sector", "subsector"),
    relationship = "many-to-many"
  )
}

add_risk_category <- function(data,
                              low_threshold,
                              high_threshold,
                              ...) {
  mutate(data, risk_category = categorize_risk(
    .data$values_to_categorize, low_threshold, high_threshold, ...
  ))
}

pstr_check <- function(scenarios) {
  check_has_no_na(scenarios, "reductions")
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)
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
      i = "Did you need to prepare the data with `pstr_prepare_scenarios()`?"
    ))
  }
  invisible(scenarios)
}

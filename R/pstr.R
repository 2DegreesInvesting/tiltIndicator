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
pstr <- function(companies, scenarios, low_threshold = 30, high_threshold = 70) {
  companies |>
    pstr_at_product_level(scenarios, low_threshold, high_threshold) |>
    xctr_at_company_level()
}

#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies, scenarios, low_threshold = 30, high_threshold = 70) {
  pstr_check(scenarios)

  companies <- rename(companies, companies_id = "company_id")
  companies |>
    pstr_add_reductions(scenarios) |>
    pstr_add_transition_risk(low_threshold, high_threshold) |>
    xstr_polish_output_at_product_level() |>
    # TODO: DRY with ISTR
    select(all_of(pstr_cols_at_product_level()))
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

pstr_check <- function(scenarios) {
  check_has_no_na(scenarios, "reductions")
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)
}

stop_if_all_sector_and_subsector_are_na_for_some_type <- function(scenarios) {
  bad <- scenarios |>
    summarize(
      all_na = all(is.na(.data$sector) & is.na(.data$subsector)), .by = "type"
    ) |>
    filter(.data$all_na) |>
    pull(.data$type)

  has_bad_type <- !identical(bad, character(0))
  if (has_bad_type) {
    type <- toString(bad)
    abort(c(
      "Each scenario `type` must have some `sector` and `subsector`.",
      x = glue("All `sector` and `subsector` are missing for `type` {type}."),
      i = "Did you need to prepare the data with `pstr_prepare_scenarios()`?"
    ))
  }
  invisible(scenarios)
}

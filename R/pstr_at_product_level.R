#' @rdname pstr
#' @export
pstr_at_product_level <- function(companies,
                                  scenarios,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  xstr_check(companies, scenarios)

  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)
  .companies <- prepare_companies(companies)

  .companies |>
    xstr_add_values_to_categorize(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    xstr_polish_output_at_product_level() |>
    pstr_select_cols_at_product_level() |>
    polish_output(cols_at_product_level())
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

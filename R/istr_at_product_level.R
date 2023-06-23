#' @rdname istr
#' @export
istr_at_product_level <- function(companies,
                                  scenarios,
                                  inputs,
                                  low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                  high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  xstr_check(companies, scenarios)

  .companies <- prepare_companies(companies)
  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)
  .inputs <- prepare_inputs(inputs)

  .inputs |>
    xstr_add_values_to_categorize(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    xctr_join_companies(.companies) |>
    xstr_polish_output_at_product_level() |>
    istr_select_cols_at_product_level() |>
    polish_output(cols_at_product_level())
}

prepare_inputs <- function(data) {
  distinct(data)
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

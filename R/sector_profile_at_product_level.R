sector_profile_at_product_level <- function(companies,
                                            scenarios,
                                            low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                            high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  spa_check(companies, scenarios)

  .companies <- prepare_companies(companies)
  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)

  .companies |>
    spa_add_values_to_categorize(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    spa_polish_output_at_product_level() |>
    pstr_select_cols_at_product_level() |>
    polish_output(cols_at_product_level())
}

pstr_select_cols_at_product_level <- function(data) {
  select(data, all_of(sp_cols_at_product_level()))
}

sp_cols_at_product_level <- function() {
  c(
    spa_cols_at_product_level(),
    aka("tsubsector")
  )
}

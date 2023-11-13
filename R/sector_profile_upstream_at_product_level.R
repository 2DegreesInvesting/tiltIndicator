sector_profile_upstream_at_product_level <- function(companies,
                                                     scenarios,
                                                     inputs,
                                                     low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                                     high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  x <- list(companies = companies, scenarios = scenarios, inputs = inputs)
  spa_check(x)

  .companies <- prepare_companies(companies)
  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)
  .inputs <- prepare_inputs(inputs)

  .inputs |>
    spa_compute_profile_ranking(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    join_companies(remove_col_scenario(.companies)) |>
    spa_polish_output_at_product_level() |>
    spu_select_cols_at_product_level() |>
    polish_output(cols_at_product_level())
}

prepare_inputs <- function(data) {
  distinct(data)
}

spu_select_cols_at_product_level <- function(data) {
  data |>
    select(
      ends_with(rowid()),
      all_of(spu_cols_at_product_level())
    )
}

spu_cols_at_product_level <- function() {
  c(
    spa_cols_at_product_level(),
    aka("iuid"),
    aka("itsector"),
    aka("itsubsector")
  )
}

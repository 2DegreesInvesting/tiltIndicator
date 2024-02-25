sector_profile_at_product_level <- function(companies,
                                            scenarios,
                                            low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                            high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  x <- list(companies = companies, scenarios = scenarios)
  spa_check(x)

  .companies <- prepare_companies(companies)
  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)

  .companies |>
    spa_compute_profile_ranking(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    spa_polish_output_at_product_level() |>
    sp_select_cols_at_product_level() |>
    mutate(grouped_by = ifelse(
      grepl("NA", grouped_by),
      NA_character_,
      grouped_by
    ))
}

sp_select_cols_at_product_level <- function(data) {
  data |>
    select(
      ends_with(rowid()),
      all_of(sp_cols_at_product_level())
    )
}

sp_cols_at_product_level <- function() {
  c(
    spa_cols_at_product_level(),
    aka("tsubsector")
  )
}

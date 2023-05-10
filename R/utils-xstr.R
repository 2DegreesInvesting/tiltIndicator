xstr_at_company_level <- function(data, companies) {
  n_products_per_companies <- companies |>
    group_by(.data$companies_id) |>
    summarise(total_products_per_company = n())

  with_risk_category <- data |>
    left_join(
      n_products_per_companies,
      by = c("companies_id"),
      relationship = "many-to-many"
    )

  useful_cols <- c(
    "companies_id",
    "risk_category",
    "total_products_per_company",
    "scenario",
    "year"
  )
  out <- with_risk_category |>
    select(all_of(all_of(useful_cols))) |>
    group_by(.data$companies_id, .data$risk_category, .data$scenario, .data$year) |>
    reframe(score_aggregated = (n() / .data$total_products_per_company)) |>
    group_by(.data$companies_id, .data$risk_category, .data$scenario, .data$year) |>
    distinct() |>
    ungroup()

  xstr_polish_output_at_company_level(out)
}

xstr_polish_output_at_product_level <- function(data) {
  data |>
    ungroup() |>
    rename(risk_category = "transition_risk") |>
    unite("grouped_by", "scenario", "year", remove = FALSE) |>
    relocate(all_of(cols_at_all_levels()))
}

xstr_polish_output_at_company_level <- function(data) {
  data |>
    unite("grouped_by", "scenario", "year", remove = FALSE) |>
    rename(value = "score_aggregated") |>
    relocate(all_of(cols_at_company_level()))
}

xstr_check <- function(scenarios) {
  check_has_no_na(scenarios, "reductions")
}


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

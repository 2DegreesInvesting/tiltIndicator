xstr_polish_output <- function(data) {
  data |>
    rename(risk_category = "transition_risk") |>
    rename(value = "score_aggregated") |>
    unite("grouped_by", "scenario", "year") |>
    relocate_crucial_output_columns() |>
    ungroup() |>
    select(-"company_name")
}

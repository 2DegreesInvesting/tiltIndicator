xstr_check <- function(scenarios) {
  if (identical(nrow(scenarios), 0L)) {
    abort("`scenarios` can't have 0-row.")
  }
  check_has_no_na(scenarios, "reductions")
}

xstr_polish_output_at_product_level <- function(data) {
  data |>
    ungroup() |>
    rename(risk_category = "transition_risk") |>
    unite(
      "grouped_by",
      # hack #305
      if (hasName(data, "type")) "type" else NULL,
      "scenario",
      "year",
      remove = FALSE
    ) |>
    relocate(all_of(cols_at_all_levels()))
}

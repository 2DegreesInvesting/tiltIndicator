xstr_check <- function(companies, scenarios) {
  stop_if_has_0_rows(companies)
  stop_if_has_0_rows(scenarios)
}

xstr_polish_output_at_product_level <- function(data) {
  data |>
    ungroup() |>
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

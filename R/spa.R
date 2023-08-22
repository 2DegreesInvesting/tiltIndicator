spa_check <- function(companies, scenarios) {
  stop_if_has_0_rows(companies)
  stop_if_has_0_rows(scenarios)
  crucial <- c("type", "sector", "subsector", "year", "scenario")
  check_crucial_names(scenarios, crucial)
  stop_if_all_sector_and_subsector_are_na_for_some_type(scenarios)
  check_no_semicolon(companies)
}

stop_if_all_sector_and_subsector_are_na_for_some_type <- function(scenarios) {
  bad_type <- scenarios |>
    summarize(
      all_na = all(is.na(.data$sector) & is.na(.data$subsector)), .by = "type"
    ) |>
    filter(.data$all_na) |>
    pull(.data$type)

  has_bad_type <- !identical(bad_type, character(0))
  if (has_bad_type) {
    bad <- toString(bad_type)
    abort(c(
      "Each scenario `type` must have some `sector` and `subsector`.",
      x = glue("All `sector` and `subsector` are missing for `type` {bad}."),
      i = "Did you need to prepare the data with `spa_prepare_scenario()`?"
    ))
  }
  invisible(scenarios)
}

prepare_scenarios <- function(data, low_threshold, high_threshold) {
  data |>
    mutate(low_threshold = low_threshold, high_threshold = high_threshold) |>
    distinct() |>
    rename(values_to_categorize = "reductions")
}

spa_add_values_to_categorize <- function(data, scenarios) {
  left_join(
    data, scenarios,
    by = join_by("type", "sector", "subsector"),
    relationship = "many-to-many"
  )
}

spa_polish_output_at_product_level <- function(data) {
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

spa_cols_at_product_level <- function() {
  c(
    cols_at_product_level(),
    "tilt_sector",
    "scenario",
    "year",
    "type"
  )
}

check_no_semicolon <- function(data) {
  relevant_cols <- data |>
    select(-starts_with("tilt_")) |>
    select(ends_with("sector"))

  has_relevant_cols <- ncol(relevant_cols) > 0L
  if (!has_relevant_cols) {
    return(data)
  }

  has_semicolon <- any(map_lgl(relevant_cols, ~ any(grepl(";", .x))))
  if (!has_semicolon) {
    return(data)
  }

  warn(c(
    "The `*sector` columns used to match scenarios shouln't have semicolon ';'.",
    x = "Unmatched values of `sector` and `subsector` result in `NA`s.",
    i = "Do you need see the evolution of this issue on GitHub (#448)?"
  ))

  data
}

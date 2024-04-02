spa_check <- function(x) {
  stop_if_has_0_rows(x$companies)
  stop_if_has_0_rows(x$scenarios)

  check_matches_name(x$companies, pattern = id_pattern())

  crucial <- c(
    aka("scenario_type"),
    aka("scenario_name"),
    aka("xsector"),
    aka("xsubsector"),
    aka("xyear")
  )
  check_crucial_names(x$scenarios, crucial)
  stop_if_all_sector_and_subsector_are_na_for_some_type(x$scenarios)
  check_no_semicolon(x$companies)

  check_rowid(x)
}

stop_if_all_sector_and_subsector_are_na_for_some_type <- function(scenarios) {
  bad_type <- scenarios |>
    summarize(
      all_na = all(is.na(.data$sector) & is.na(.data$subsector)), .by = aka("scenario_type")
    ) |>
    filter(.data$all_na) |>
    pull(.data$type)

  has_bad_type <- !identical(bad_type, character(0))
  if (has_bad_type) {
    bad <- toString(bad_type)
    abort(c(
      "Each scenario `type` must have some `sector` and `subsector`.",
      x = glue("All `sector` and `subsector` are missing for `type` {bad}."),
      i = hint_needs_prep()
    ))
  }
  invisible(scenarios)
}

prepare_scenarios <- function(data, low_threshold, high_threshold) {
  data |>
    mutate(low_threshold = low_threshold, high_threshold = high_threshold) |>
    distinct() |>
    rename(profile_ranking = aka("co2reduce")) |>
    warn_non_default_thresholds()
}

warn_non_default_thresholds <- function(data, ...) {
  warn_non_default_thresholds_impl(data, year == 2030, .threshold = "low_threshold")
  warn_non_default_thresholds_impl(data, is.na(year) | year != 2030, .threshold = "low_threshold")
  warn_non_default_thresholds_impl(data, year == 2030, .threshold = "high_threshold")
  warn_non_default_thresholds_impl(data, is.na(year) | year != 2030, .threshold = "high_threshold")

  invisible(data)
}

warn_non_default_thresholds_impl <- function(data, .threshold, ...) {
  data$year <- as.integer(data$year)

  thresholds <- distinct(data, year, low_threshold, high_threshold)
  year_data <- filter(thresholds, ...)
  if (nrow(year_data) == 1L) {
    actual <- as.double(year_data[[.threshold]])
    default <- as.double(filter(default_thresholds(), ...)[[.threshold]])
    same <- identical(actual, default)
    if (!same) {
      rlang::warn(glue::glue("Using a non-default `{.threshold}`: {actual}."))
    }
  }
}

default_thresholds <- function() {
  # styler: off
  tibble::tribble(
    ~year, ~low_threshold, ~high_threshold,
     2030,            1/9,             2/9,
       NA,            1/3,             2/3,
  )
  # styler: on
}

spa_compute_profile_ranking <- function(data, scenarios) {
  left_join(
    data, scenarios,
    by = c(aka("scenario_type"), aka("xsector"), aka("xsubsector")),
    relationship = "many-to-many"
  )
}

spa_polish_output_at_product_level <- function(data) {
  data |>
    ungroup() |>
    unite(
      "grouped_by",
      # hack #305
      if (hasName(data, aka("scenario_type"))) aka("scenario_type") else NULL,
      aka("scenario_name"),
      aka("xyear"),
      remove = FALSE
    ) |>
    relocate(all_of(cols_at_all_levels()))
}

spa_cols_at_product_level <- function() {
  c(
    cols_at_product_level(),
    aka("tsector"),
    aka("scenario_name"),
    aka("xyear"),
    aka("scenario_type")
  )
}

check_no_semicolon <- function(data) {
  relevant_cols <- data |>
    select(-starts_with("tilt_")) |>
    select(ends_with(aka("xsector")))

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

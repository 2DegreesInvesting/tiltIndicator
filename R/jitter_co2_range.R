jitter_co2_range <- function(data, amount = 0.1) {
  check_jitter_co2_range(data)

  clean <- remove_missing_values_from_crucial_columns(data)
  x <- clean[[find_co2_footprint(clean)]]
  .by <- c("grouped_by", "risk_category")

  clean |>
    mutate(lower = min(x), upper = max(x), .by = all_of(.by)) |>
    distinct(.data$grouped_by, .data$risk_category, .data$lower, .data$upper) |>
    expand_jitter_range(lower = .data$lower, upper = .data$upper, amount = 0.1)
}

check_jitter_co2_range <- function(data) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))
}

remove_missing_values_from_crucial_columns <- function(data) {
  col_to_range <- find_co2_footprint(data)

  data |>
    remove_na_from("grouped_by") |>
    remove_na_from("risk_category") |>
    remove_na_from(col_to_range)
}

expand_jitter_range <- function(data, lower, upper, amount) {
  mutate(
    data,
    lower_jitter = jitter_left(lower, amount),
    upper_jitter = jitter_right(upper, amount)
  )
}

remove_na_from <- function(data, name) {
  if (!anyNA(data[[name]])) {
    data
  } else {
    warn_removing_na_from(data, name)
    filter(data, !is.na(data[[name]]))
  }
}

warn_removing_na_from <- function(data, name) {
  .n <- sum(is.na(data[[name]]))
  warn(glue("Removing {.n} `NA` from `{name}`."), class = "removing_na_from")
  invisible(data)
}

jitter_co2_range <- function(data, amount = 0.1) {
  check_jitter_co2_range(data)

  data |>
    remove_missing_values_from_crucial_columns() |>
    add_range_by(c("grouped_by", "risk_category")) |>
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

add_range_by <- function(data, .by = c("grouped_by", "risk_category")) {
  col_to_range <- find_co2_footprint(data)

  with_range <- mutate(
    data,
    lower = min(data[[col_to_range]]),
    upper = max(data[[col_to_range]]),
    .by = all_of(.by)
  )
}

pick_crucial_data <- function(data) {
  distinct(data, .data$grouped_by, .data$risk_category, .data$lower, .data$upper)
}

expand_jitter_range <- function(data, lower, upper, amount) {
  mutate(
    data,
    lower_jitter = jitter_left(lower, amount),
    upper_jitter = jitter_right(upper, amount)
  )
}

remove_na_from <- function(data, name) {
  if (anyNA(data[[name]])) {
    warn_removing_na_from(data, name)
    data <- filter(data, !is.na(data[[name]]))
  }
  data
}

warn_removing_na_from <- function(data, name) {
  .n <- sum(is.na(data[[name]]))
  warn(glue("Removing {.n} `NA` from `{name}`."), class = "removing_na_from")
  invisible(data)
}

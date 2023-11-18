jitter_range <- function(data, amount = 0.1) {
  # TODO generalize with `x`, `.by`. That way we can remove reference to co2

  check_jitter_range(data)

  clean <- remove_missing_values_from_crucial_cols_to_range(data)
  x <- clean[[find_co2_footprint(clean)]]
  clean |>
    mutate(lower = min(x), upper = max(x), .by = all_of(cols_to_range_by())) |>
    distinct(.data$grouped_by, .data$risk_category, .data$lower, .data$upper) |>
    expand_jitter_range(lower = .data$lower, upper = .data$upper, amount = 0.1)
}

check_jitter_range <- function(data) {
  crucial <- c(cols_to_range_by(), aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))
}

remove_missing_values_from_crucial_cols_to_range <- function(data) {
  col_to_range <- find_co2_footprint(data)
  crucial <- c(cols_to_range_by(), col_to_range)

  for (i in seq_along(crucial)) {
    data <- remove_na_from(data, crucial[[i]])
  }

  data
}

expand_jitter_range <- function(data, lower, upper, amount) {
  mutate(
    data,
    lower_jitter = jitter_left(lower, amount),
    upper_jitter = jitter_right(upper, amount)
  )
}

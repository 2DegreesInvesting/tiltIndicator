jitter_range <- function(data, amount = 0.1) {
  column_name <- find_co2_footprint(data)
  .by <- cols_to_range_by()

  # TODO Document as a post-processing helper. Internal?
  # TODO Discuss how to handle the licensed data. Rely on removing it later?

  check_jitter_range(data)

  clean <- remove_missing_from_cols(data, c(cols_to_range_by(), column_name))
  x <- clean[[column_name]]
  clean |>
    mutate(minimum = min(x), maximum = max(x), .by = all_of(.by)) |>
    distinct(.data$grouped_by, .data$risk_category, .data$minimum, .data$maximum) |>
    expand_jitter_range(minimum = .data$minimum, maximum = .data$maximum, amount = 0.1)
}

check_jitter_range <- function(data) {
  crucial <- c(cols_to_range_by(), aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))
}

remove_missing_from_cols <- function(data, column_names = NULL) {
  for (i in seq_along(column_names)) {
    data <- remove_na_from(data, column_names[[i]])
  }

  data
}

expand_jitter_range <- function(data, minimum, maximum, amount) {
  mutate(
    data,
    minimum_jitter = jitter_left(minimum, amount),
    maximum_jitter = jitter_right(maximum, amount)
  )
}

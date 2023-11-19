# TODO Document as a post-processing helper. Internal?
# TODO Discuss how to handle the licensed data. Rely on removing it later?
jitter_range <- function(data, col = find_co2_footprint(data), .by = cols_to_range_by(), amount = 0.1) {
  range_col_by <- function(data, col, .by) {
    crucial <- c(.by, col)
    check_jitter_range(data, crucial)

    clean <- remove_missing_values(data, crucial)

    vaules <- clean[[col]]
    with_range <- clean |>
      mutate(minimum = min(vaules), maximum = max(vaules), .by = all_of(.by)) |>
      distinct(!!!rlang::syms(.by), .data$minimum, .data$maximum)
  }

  data |>
    range_col_by(col, .by = .by) |>
    expand_jitter_range(minimum = .data$minimum, maximum = .data$maximum, amount = 0.1)
}

check_jitter_range <- function(data, crucial) {
  walk(crucial, \(x) check_matches_name(data, x))
}

remove_missing_values <- function(data, column_names = NULL) {
  remove_missing_values_once <- function(data, name) {
    missing <- anyNA(data[[name]])
    if (!missing) {
      return(data)
    } else {
      warn_removing_na_from(data, name)
      filter(data, !is.na(data[[name]]))
    }
  }

  for (i in seq_along(column_names)) {
    data <- remove_missing_values_once(data, column_names[[i]])
  }

  data
}

warn_removing_na_from <- function(data, name) {
  .n <- sum(is.na(data[[name]]))
  warn(glue("Removing {.n} `NA` from `{name}`."), class = "removing_na_from")

  invisible(data)
}

expand_jitter_range <- function(data, minimum, maximum, amount) {
  mutate(
    data,
    minimum_jitter = jitter_left(minimum, amount),
    maximum_jitter = jitter_right(maximum, amount)
  )
}

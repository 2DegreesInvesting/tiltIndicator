# TODO Document as a post-processing helper. Internal?
# TODO Discuss how to handle the licensed data. Rely on removing it later?
jitter_range <- function(data, column = find_co2_footprint(data), .by = cols_to_range_by(), amount = 0.1) {
  data |>
    range_column(column, .by = .by) |>
    jitter_min("min", amount) |>
    jitter_max("max", amount)
}

range_column <- function(data, column, .by) {
  crucial <- c(column, .by)
  check_jitter_range(data, crucial)

  clean <- remove_missing_values(data, crucial)

  vaules <- clean[[column]]
  with_range <- clean |>
    mutate(min = min(vaules), max = max(vaules), .by = all_of(.by)) |>
    distinct(!!!rlang::syms(.by), .data$min, .data$max)
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

jitter_min <- function(data, col = "min", amount = 0.1) {
  x <- data[[col]]
  mutate(data, min_jitter = x - jitter_abs(x, amount))
}

jitter_max <- function(data, col = "max", amount = 0.1) {
  x <- data[[col]]
  mutate(data, max_jitter = x + jitter_abs(x, amount))
}

jitter_abs <- function(x, amount = 0.1) {
  abs(amount * rnorm(length(x)))
}

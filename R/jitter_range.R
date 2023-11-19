# TODO Document as a post-processing helper. Internal?
# TODO Discuss how to handle the licensed data. Rely on removing it later?
jitter_range <- function(data, col, .by = NULL, amount = 0.1) {
  data |>
    range_col(col, .by = .by) |>
    jitter_min("min", amount) |>
    jitter_max("max", amount)
}

range_col <- function(data, col, .by) {
  crucial <- c(col, .by)
  walk(crucial, \(x) check_matches_name(data, x))

  clean <- remove_missing_values(data, crucial)
  vaules <- clean[[col]]
  with_range <- clean |>
    mutate(min = min(vaules), max = max(vaules), .by = all_of(.by)) |>
    distinct(!!!rlang::syms(.by), .data$min, .data$max)
}

remove_missing_values <- function(data, cols = NULL) {
  remove_missing_values_once <- function(data, col) {
    missing <- anyNA(data[[col]])
    if (!missing) {
      return(data)
    } else {
      warn_removing_na_from(data, col)
      filter(data, !is.na(data[[col]]))
    }
  }

  for (i in seq_along(cols)) {
    data <- remove_missing_values_once(data, cols[[i]])
  }

  data
}

warn_removing_na_from <- function(data, col) {
  .n <- sum(is.na(data[[col]]))
  warn(glue("Removing {.n} `NA` from `{col}`."), class = "removing_na_from")

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

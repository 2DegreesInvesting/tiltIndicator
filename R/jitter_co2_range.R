jitter_co2_range <- function(data, amount = 0.1) {
  check_jitter_co2_range(data)

  co2_col <- find_co2_footprint(data)

  clean <- data |>
    remove_na_from("grouped_by") |>
    remove_na_from("risk_category") |>
    remove_na_from(co2_col)

  with_range <- clean |>
    mutate(
    lower = min(clean[[co2_col]]),
    upper = max(clean[[co2_col]]),
      .by = c("grouped_by", "risk_category")
    )

  relevant_rows <- with_range |>
    distinct(grouped_by, risk_category, lower, upper)

  relevant_rows |>
    mutate(
      lower_jitter = jitter_left(lower, amount),
      upper_jitter = jitter_right(upper, amount)
    )
}

check_jitter_co2_range <- function(data) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))
}

remove_na_from <- function(data, col) {
  if (anyNA(data[[col]])) {
    warn_removing_na_from(data, col)
    data <- filter(data, !is.na(data[[col]]))
  }
  data
}

warn_removing_na_from <- function(data, name) {
  .n <- sum(is.na(data[[name]]))
  warn(glue("Removing {.n} `NA` from `{name}`."))
  invisible(data)
}

jitter_left <- function(x, amount = 0.1) {
  x * (1 - absolute_jitter(x, amount))
}

jitter_right <- function(x, amount = 0.1) {
  x * (1 + absolute_jitter(x, amount))
}

absolute_jitter <- function(x, amount = 0.1) {
  abs(amount * rnorm(length(x)))
}


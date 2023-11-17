jitter_co2_range <- function(data, amount = 0.1) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))

  co2_col <- find_co2_footprint(data)

  no_na <- data |>
    remove_na_from("grouped_by") |>
    remove_na_from("risk_category") |>
    remove_na_from(co2_col)

  no_na |>
    mutate(
      lower = min(no_na[[co2_col]]),
      upper = max(no_na[[co2_col]]),
      .by = c("grouped_by", "risk_category")
    ) |>
    distinct(grouped_by, risk_category, lower, upper) |>
    mutate(
      lower_jitter = jitter_left(lower, amount),
      upper_jitter = jitter_right(upper, amount)
    )
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


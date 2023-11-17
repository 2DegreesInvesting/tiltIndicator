jitter_co2_range <- function(data, amount = 0.1) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))


  values <- get_column(data, find_co2_footprint(data))
  data |>
    mutate(
      lower = min(values),
      upper = max(values),
      .by = c("grouped_by", "risk_category")
    ) |>
    distinct(grouped_by, risk_category, lower, upper) |>
    mutate(
      lower_jitter = jitter_left(lower, amount),
      upper_jitter = jitter_right(lower, amount)
    )
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


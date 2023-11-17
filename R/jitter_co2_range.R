jitter_co2_range <- function(data) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))

  data |>
    add_co2_range()
}

add_co2_range <- function(data) {
  values <- get_column(data, find_co2_footprint(data))

  data |>
    mutate(
      lower = min(values),
      upper = max(values),
      .by = c("grouped_by", "risk_category")
    ) |>
    distinct(grouped_by, risk_category, lower, upper)
}


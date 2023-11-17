jitter_co2_range <- function(data) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))

  data |>
    add_co2_range()
}

add_co2_range <- function(data) {
  data |>
    mutate(
      lower = min(find_co2_footprint(data)),
      upper = max(find_co2_footprint(data)),
      .by = c("grouped_by", "risk_category")
    )
}


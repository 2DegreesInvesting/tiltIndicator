add_rank <- function(data, x, .by) {
  nm <- as.symbol(paste0("perc_", .by))
  mutate(data, "{{ nm }}" := rank_proportion(.data[[x]]), .by = all_of(.by))
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

ictr_add_ranks <- function(data) {
  browser()

  .by <- list("unit", "input_sector", c("unit", "input_sector"))


  out <- data %>%
    mutate(perc_all = rank_proportion(.data$input_co2)) |>
    add_rank(x = "input_co2", .by = "unit") |>
    mutate(perc_sec = rank_proportion(.data$input_co2), .by = "input_sector") %>%
    mutate(perc_unit_sec = rank_proportion(.data$input_co2), .by = c("unit", "input_sector"))

  out
}

pctr_add_ranks <- function(data) {
  data |>
    mutate(perc_all = rank(.data$co2_footprint) / length(.data$co2_footprint)) |>
    # rank in comparison to all products with same unit
    group_by(.data$unit) |>
    mutate(perc_unit = rank(.data$co2_footprint) / length(.data$co2_footprint)) %>%
    ungroup() |>
    # rank in comparison to all products with same unit and sector
    group_by(.data$unit, .data$sec) |>
    mutate(perc_unit_sec = rank(.data$co2_footprint) / length(.data$co2_footprint)) %>%
    ungroup()
}



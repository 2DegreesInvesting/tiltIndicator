
add_rank <- function(data, col) {
  nm <- paste0("perc_", col)
  mutate(data, {{ nm }} := rank(.data[[col]]) / length(.data[[col]]))
}

ictr_add_ranks <- function(data) {
  data %>%
    ## rank in comparison to all input products
    mutate(perc_all = rank(.data$input_co2) / length(.data$input_co2)) |>
    ## rank in comparison to all input products with same unit
    group_by(.data$unit) |>
    mutate(perc_unit = rank(.data$input_co2) / length(.data$input_co2)) %>%
    ungroup() |>
    ## rank in comparison to all input products with same input sector
    group_by(.data$input_sector) |>
    mutate(perc_sec = rank(.data$input_co2) / length(.data$input_co2)) %>%
    ungroup() |>
    ## rank in comparison to all input products with same unit and input sector
    group_by(.data$unit, .data$input_sector) |>
    mutate(perc_unit_sec = rank(.data$input_co2) / length(.data$input_co2)) %>%
    ungroup()
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



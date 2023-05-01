add_rank <- function(data, x, .by) {
  suffix <- "all"
  ..by <- NULL
  if (!is.null(.by)) {
    suffix <- paste(.by, collapse = "_")
    ..by <- .by
  }

  nm <- as.symbol(paste0("perc_", suffix))
  mutate(data, "{{ nm }}" := rank_proportion(.data[[x]]), .by = all_of(..by))
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

ictr_add_ranks <- function(data) {
  browser()

  tmp <- rename(data, sec = "input_sector")

  out <- tmp %>%
    mutate(perc_all = rank_proportion(.data$input_co2)) |>
    add_rank("input_co2", .by = "unit") |>
    add_rank("input_co2", .by = "sec") |>
    add_rank("input_co2", .by = c("unit", "sec"))

  out |> rename(input_sector = "sec")
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



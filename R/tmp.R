add_rank <- function(data, x, .by) {
  if (identical(.by, "all")) {
    suffix <- "all"
    ..by <- NULL
  } else {
    suffix <- paste(.by, collapse = "_")
    ..by <- .by
  }

  nm <- as.symbol(paste0("perc_", suffix))
  mutate(data, "{{ nm }}" := rank_proportion(.data[[x]]), .by = all_of(..by))
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

xctr_add_ranks <- function(data, x, .by) {
  out <- data
  for (i in seq_along(.by)) {
    out <- add_rank(out, x, .by = .by[[i]])
  }
  out
}

ictr_add_ranks <- function(data) {
  .by <- list(
    "all",
    "unit",
    "sec",
    c("unit", "sec")
  )

  out <- data
  for (i in seq_along(.by)) {
    out <- add_rank(out, "input_co2", .by = .by[[i]])
  }
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



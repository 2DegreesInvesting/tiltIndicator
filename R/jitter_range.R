jitter_range <- function(data, amount = 0.1) {
  check_crucial_names(data, c("min", "max"))

  data |>
    mutate(min_jitter = jitter_towards(min, "left")) |>
    mutate(max_jitter = jitter_towards(max, "left"))
}

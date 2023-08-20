prepare_co2 <- function(data, low_threshold, high_threshold) {
  data |>
    mutate(low_threshold = low_threshold, high_threshold = high_threshold) |>
    distinct() |>
    rename(
      tilt_sec = ends_with("tilt_sector"),
      unit = ends_with("unit"),
      isic_sec = ends_with("isic_4digit")
    )
}

sanitize_co2 <- function(co2) {
  pad_column(co2, "isic_4digit", width = 4, pad = "0")
}

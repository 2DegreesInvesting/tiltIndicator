prepare_co2 <- function(data, low_threshold, high_threshold) {
  data |>
    mutate(low_threshold = low_threshold, high_threshold = high_threshold) |>
    distinct() |>
    rename_benchmark_columns()
}

sanitize_co2 <- function(co2) {
  pad_column(co2, pattern = aka("isic"), width = 4, pad = "0")
}

pull_isic <- function(co2) {
  get_column(co2, aka("isic"))
}

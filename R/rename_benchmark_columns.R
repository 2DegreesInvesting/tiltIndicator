rename_benchmark_columns <- function(data) {
  data |>
    rename(
      tilt_sec = ends_with(aka("tsector")),
      unit = ends_with(aka("xunit")),
      isic_sec = ends_with(aka("isic"))
    )
}

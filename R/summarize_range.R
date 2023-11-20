summarize_range <- function(data, col, na.rm = FALSE, .by = NULL) {
  data |>
    summarize(
      min = min({{ col }}, na.rm = na.rm),
      max = max({{ col }}, na.rm = na.rm),
      .by = {{ .by }}
    )
}

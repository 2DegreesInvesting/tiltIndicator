summarize_range <- function(data, col, .by = NULL) {
  summarize(data, min = min({{ col }}), max = max({{ col }}), .by = {{ .by }})
}

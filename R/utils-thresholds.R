
warn_custom_threshold <- function(data, ...) {
  warn_threshold(data, "low_threshold", year == "2030")
  warn_threshold(data, "low_threshold", year != "2030")
  warn_threshold(data, "high_threshold", year == "2030")
  warn_threshold(data, "high_threshold", year != "2030")

  invisible(data)
}

warn_threshold <- function(data, .threshold, ...) {
  data$year <- as.character(data$year)

  thresholds <- distinct(data, year, low_threshold, high_threshold)
  year_data <- filter(thresholds, ...)
  if (nrow(year_data) == 1L) {
    actual <- as.double(year_data[[.threshold]])
    default <- as.double(filter(default_thresholds(), ...)[[.threshold]])
    same <- identical(actual, default)
    if (!same) {
      rlang::warn(glue::glue("Using a non-default `{.threshold}`: {actual}."))
    }
  }

  invisible(data)
}

default_thresholds <- function() {
  # styler: off
  tibble::tribble(
      ~year, ~low_threshold, ~high_threshold,
     "2030",            1/9,             2/9,
    "other",            1/3,             2/3,
  )
  # styler: on
}

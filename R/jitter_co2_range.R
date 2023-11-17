jitter_co2_range <- function(data, amount = 0.1) {
  crucial <- c("grouped_by", "risk_category", aka("co2footprint"))
  walk(crucial, \(x) check_matches_name(data, x))

  sanitize_col <- function(data, col) {
    if (anyNA(data[[col]])) {
      warn_removing_na_from(data, col)
      filter(data, !is.na(data[[col]]))
    }
  }

  col <- "grouped_by"
  if (anyNA(data[[col]])) {
    warn_removing_na_from(data, col)
    data <- filter(data, !is.na(data[[col]]))
  }

  col <- "risk_category"
  if (anyNA(data[[col]])) {
    warn_removing_na_from(data, col)
    data <- filter(data, !is.na(data[[col]]))
  }

  col <- co2_col <- find_co2_footprint(data)
  if (anyNA(data[[col]])) {
    warn_removing_na_from(data, col)
    data <- filter(data, !is.na(data[[col]]))
  }

  data |>
    mutate(
      lower = min(data[[co2_col]], na.rm = TRUE),
      upper = max(data[[co2_col]], na.rm = TRUE),
      .by = c("grouped_by", "risk_category")
    ) |>
    distinct(grouped_by, risk_category, lower, upper) |>
    mutate(
      lower_jitter = jitter_left(lower, amount),
      upper_jitter = jitter_right(upper, amount)
    )
}

warn_removing_na_from <- function(data, name) {
  .n <- sum(is.na(data[[name]]))
  warn(glue("Removing {.n} `NA` from `{name}`."))
  invisible(data)
}

jitter_left <- function(x, amount = 0.1) {
  x * (1 - absolute_jitter(x, amount))
}

jitter_right <- function(x, amount = 0.1) {
  x * (1 + absolute_jitter(x, amount))
}

absolute_jitter <- function(x, amount = 0.1) {
  abs(amount * rnorm(length(x)))
}


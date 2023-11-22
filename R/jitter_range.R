#' Expand a range adding some random noise
#'
#' This function expands a range by adding noise to the left of the minimum
#' values and to the right of the maximum values.
#'
#' @param data A dataframe with columns `min` and `max`.
#' @inheritParams base::jitter
#'
#' @family helpers
#'
#' @return The input dataframe with the additional columns `min_jitter` and
#'   `max_jitter`.
#' @export
#'
#' @examples
#' library(tibble)
#'
#' data <- tibble(min = 1:2, max = 3:4)
#'
#' data |> jitter_range()
#'
#' data |> jitter_range(amount = 0.9)
jitter_range <- function(data, factor = 1, amount = NULL) {
  data |>
    mutate(
      min_jitter = min |>
        jitter_towards("left", factor = factor, amount = amount),
      max_jitter = max |>
        jitter_towards("right", factor = factor, amount = amount)
    )
}

jitter_towards <- function(x, towards = c("left", "right"), factor = 1, amount = NULL) {
  towards <- rlang::arg_match(towards)

  sign <- switch(towards,
    left = `-`,
    right = `+`
  )

  sign(x, jitter_abs(x, factor = factor, amount = amount))
}

jitter_abs <- function(x, factor = 1, amount = NULL) {
  abs(abs(x) - abs(jitter(x, factor = factor, amount = amount)))
}

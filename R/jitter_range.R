#' Expand a range adding some random noise
#'
#' This function expands a range by adding noise to the left of the minimum
#' values and to the right of the maximum values.
#'
#' @param data A dataframe with columns `min` and `max`.
#' @inheritParams base::jitter
#'
#' @seealso [jitter()]
#'
#' @family helpers
#'
#' @return The input dataframe with the additional columns `min_jitter` and
#'   `max_jitter`.
#' @export
#'
#' @examples
#' library(tibble)
#' set.seed(123)
#'
#' data <- tibble(min = -2:2, max = -1:3)
#'
#' data |> jitter_range(amount = 0.1)
#'
#' data |> jitter_range(amount = 2)
jitter_range <- function(data, factor = 1, amount = NULL) {
  check_crucial_names(data, c("min", "max"))

  mutate(
    data,
    min_jitter = jitter_left(min, factor = factor, amount = amount),
    max_jitter = jitter_right(max, factor = factor, amount = amount)
  )
}

jitter_right <- function(x, factor, amount) {
  x + noise(x, factor, amount)
}

jitter_left <- function(x, factor, amount) {
  x - noise(x, factor, amount)
}

noise <- function(x, factor, amount) {
  ifelse(
    x == 0,
    noise_zero(x, factor, amount),
    noise_other(x, factor, amount)
  )
}

noise_zero <- function(x, factor, amount) {
  abs(jitter(x, factor, amount) - abs(x))
}

noise_other <- function(x, factor, amount) {
  factor <- abs(abs(x) - abs(jitter(x, factor, amount)))
  abs(x * factor)
}

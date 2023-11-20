#' Expand a range (towards the left and right) adding an amount of random noise
#'
#' @param data A dataframe with columns `min` and `max`.
#' @param amount Numeric. A single value giving the amount of jitter.
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
jitter_range <- function(data, amount = 0.1) {
  data |>
    mutate(min_jitter = min |> jitter_towards("left", amount = amount)) |>
    mutate(max_jitter = max |> jitter_towards("right", amount = amount))
}

jitter_towards <- function(x, towards = c("left", "right"), amount = 0.1) {
  towards <- rlang::arg_match(towards)

  sign <- switch(towards,
    left = `-`,
    right = `+`
  )

  sign(x, jitter_abs(x, amount))
}

jitter_abs <- function(x, amount = 0.1) {
  abs(amount * rnorm(length(x)))
}

#' Add a small amount of random noise to a vector, towards the left or right
#'
#' @param x A numeric vector.
#' @param towards Character. Either "left" (default) or "right".
#' @param amount Numeric. A single value giving the amount of jitter.
#'
#' @family post-processing helpers
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' 1:3 |> jitter_towards("left")
#'
#' 1:3 |> jitter_towards("right")
#'
#' 1:3 |> jitter_towards("right", amount = 0.9)
jitter_towards <- function(x, towards = c("left", "right"), amount = 0.1) {
  if (!is.numeric(x)) abort(glue("`x` must be numeric but it's a {typeof(x)}."))

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

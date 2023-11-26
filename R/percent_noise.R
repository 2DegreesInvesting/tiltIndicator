#' Calculate percent noise
#'
#' @param x Numeric vector.
#' @param noisy Numeric vector.
#'
#' @return Numeric vector.
#' @export
#'
#' @keywords internal
#'
#' @examples
#' x <- -10:10
#' noisy <- jitter(x)
#' out <- percent_noise(x, noisy)
#' out
#'
#' finite <- out[is.finite(out)]
#' mean(finite)
percent_noise <- function(x, noisy) {
  noise <- abs(abs(x) - abs(noisy))
  noise * 100 / x
}

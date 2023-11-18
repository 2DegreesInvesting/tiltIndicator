jitter_left <- function(x, amount = 0.1) {
  x - absolute_jitter(x, amount)
}

jitter_right <- function(x, amount = 0.1) {
  x + absolute_jitter(x, amount)
}

absolute_jitter <- function(x, amount = 0.1) {
  abs(amount * rnorm(length(x)))
}

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

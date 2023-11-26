jitter_abs <- function(x, factor, amount) {
  abs(abs(x) - abs(jitter(x, factor = factor, amount = amount)))
}

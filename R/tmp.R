add_rank <- function(data, x, .by) {
  if (identical(.by, "all")) {
    suffix <- "all"
    ..by <- NULL
  } else {
    suffix <- paste(.by, collapse = "_")
    ..by <- .by
  }

  nm <- as.symbol(paste0("perc_", suffix))
  mutate(data, "{{ nm }}" := rank_proportion(.data[[x]]), .by = all_of(..by))
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

xctr_add_ranks <- function(data, x, .by) {
  out <- data
  for (i in seq_along(.by)) {
    out <- add_rank(out, x, .by = .by[[i]])
  }
  out
}

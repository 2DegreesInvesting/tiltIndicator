#' Format data to print robust snapshots
#'
#' Prints each column separately, one under the other. This avoids differences
#' caused by the width of the screen while preserving a format that is easy
#' to compare when a real difference happens.
#'
#' @param data A data frame or named list in general
#' @examples
#' format_robust_snapshot(BOD)
#' @noRd
format_robust_snapshot <- function(data) {
  row.names(data) <- NULL
  lapply(names(data), function(x) as.data.frame(data)[x])
}

on_rcmd <- function() {
  nzchar(Sys.getenv("R_CMD"))
}

read_test_csv <- function(file, ..., show_col_types = FALSE, n_max = 1) {
  read_csv(file, show_col_types = show_col_types, n_max = n_max)
}

# FIXME: Delete once tiltToyData#23 is solved
# Helps add snapshots of new toy datasets before tiltToyData#23 is merged
skip_if_toy_data_is_old <- function() {
  testthat::skip_if(utils::packageVersion("tiltToyData") <= "0.0.0.9007")
}

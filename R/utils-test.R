#' Run private tests
#'
#' @family developer-oriented functions
#' @return Called for its side effect.
#' @examples
#' \dontrun{
#' test_private()
#' }
#' @noRd
test_private <- function() {
  testthat::test_dir(tilt_path("tiltIndicator", "tests"))
}

#' Update snapshots in the directory for private tests
#'
#' @inheritParams testthat::snapshot_accept
#' @family developer-oriented functions
#' @return Called for its side effect.
#' @examples
#' \dontrun{
#' snapshot_accept_private()
#' }
#' @noRd
snapshot_accept_private <- function(files = NULL) {
  testthat::snapshot_accept(files = NULL, path = tilt_path("tiltIndicator", "tests"))
}

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

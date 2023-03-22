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

#' Run private tests
#'
#' @family developer-oriented functions
#' @return
#' @export
#' @examples
#' \dontrun{
#' test_private()
#' }
test_private <- function() {
  testthat::test_dir(tilt_path("tiltIndicator", "tests"))
}

#' Update snapshots in the directory for private tests
#'
#' @inheritParams testthat::snapshot_accept
#' @family developer-oriented functions
#' @return
#' @export
#' @examples
#' \dontrun{
#' snapshot_accept_private()
#' }
snapshot_accept_private <- function(files = NULL) {
  testthat::snapshot_accept(files = NULL, path = tilt_path("tiltIndicator", "tests"))
}

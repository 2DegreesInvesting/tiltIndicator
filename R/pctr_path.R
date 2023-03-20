#' Path to indicator
#'
#' @inheritDotParams fs::path
#'
#' @return A path
#' @export
#' @keywords internal
#'
#' @examples
#' pctr_path()
#' fs::dir_tree(pctr_path())
pctr_path <- function(...) {
  tilt_path("tiltIndicator", "pctr", ...)
}

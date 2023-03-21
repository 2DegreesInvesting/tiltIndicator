#' Path to indicator
#'
#' @inheritDotParams fs::path
#'
#' @return A path
#' @export
#' @family developer-oriented functions
#'
#' @examples
#' pctr_path()
pctr_path <- function(...) {
  tilt_path("tiltIndicator", "pctr", ...)
}

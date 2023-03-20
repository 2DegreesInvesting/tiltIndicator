#' Path to user data directories
#'
#' @inheritParams rappdirs::user_data_dir
#' @inheritDotParams rappdirs::user_data_dir
#'
#' @return A `r class(data_dir())`.
#' @export
#'
#' @examples
#' data_dir()
#' data_dir(version = "x.y.z")
data_dir <- function(version = NULL, ...) {
  # rappdirs::user_data_dir(appname = "tiltIndicator", version = version, ...)
}

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

#' Product carbon transition risk indicator
#'
#' @param path Path to article.
#'
#' @return A data frame.term
#'
#' @examples
#' pctr()
#' @noRd
pctr <- function(path = here::here("vignettes/articles/pctr.Rmd")) {
  wrap_rmd(path)[["company_scores"]]
}


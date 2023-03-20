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

#' Path to indicator
#'
#' @inheritDotParams fs::path
#'
#' @return A path
#'
#' @examples
#' pctr_path()
#' fs::dir_tree(pctr_path())
#' @noRd
pctr_path <- function(...) {
  tilt_path("tiltIndicator", "pctr", ...)
}

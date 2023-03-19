pctr_company_scores <- function(path = here::here("vignettes/articles/pctr.Rmd")) {
  wrap_rmd(path)[["company_scores"]]
}

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
  fs::path(data_dir(), "product-carbon-tr", ...)
}

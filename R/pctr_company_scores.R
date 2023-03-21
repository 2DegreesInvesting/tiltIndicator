#' Product carbon transition risk indicator
#'
#' @param path TODO: Replace with input data frames.
#'
#' @return A data frame
#'
#' @examples
#' path <- mvp_path("product-carbon-transition-risk.Rmd")
#' pctr_pctr_company_scores(path)
#' @noRd
pctr_company_scores <- function(path) {
  # TODO: Refactor
  # Tests run privately until we have public toy data
  wrap_rmd(path)[["company_scores"]]
}

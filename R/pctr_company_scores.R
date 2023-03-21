#' Product carbon transition risk: Company scores
#'
#' @param path FIXME Currently a path to the mvp.Rmd.
#'
#' @return A data frame giving company scores.
#'
#' @examples
#' \dontrun{
#' FIXME <- mvp_path("product-carbon-transition-risk.Rmd")
#' pctr_company_scores(FIXME)
#' }
#' @noRd
pctr_company_scores <- function(path) {
  # TODO: Refactor
  # Tests run privately until we have public toy data
  wrap_rmd(path)[["company_scores"]]
}

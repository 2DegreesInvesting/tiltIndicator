#' Product carbon transition risk indicator
#'
#' @param path Path to article.
#'
#' @return A data frame.term
#'
#' @examples
#' pctr_pctr_company_scores()
#' @noRd
pctr_company_scores <- function(path = here::here("vignettes/articles/pctr.Rmd")) {
  wrap_rmd(path)[["company_scores"]]
}

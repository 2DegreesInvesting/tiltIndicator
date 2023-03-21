#' Typically one sentence like "Given an INPUT returns an OUTPUT"
#'
#' A short introduction, typically one paragraph but maybe more.
#'
#' A longer explanation, typically multiple paragraphs but maybe one.
#'
#' @param data (Typically one or more data frames with crucial columns)
#'
#' @return (Typically one or more data frames with crucial columns)
#' @export
#'
#' @examples
#' # TODO
pctr_company_scores <- function(path) {
  # TODO: Refactor
  # Tests run privately until we have public toy data
  wrap_rmd(path)[["company_scores"]]
}

#' Calculate the ICTR indicator
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' @inheritParams ictr_score_inputs
#' @inheritParams ictr_score_companies
#'
#' @family ICTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' ictr(ictr_companies, ictr_inputs)
ictr <- function(companies, inputs) {
  out <- ictr_score_companies(ictr_score_inputs(inputs), companies)
  xctr_rename(out)
}

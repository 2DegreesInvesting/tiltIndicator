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
ictr <- function(companies, inputs, low_threshold = 0.3, high_threshold = 0.7) {
  scored <- ictr_score_inputs(
    inputs,
    low_threshold = low_threshold,
    high_threshold = high_threshold
  )

  out <- ictr_score_companies(scored, companies)

  out |>
    xctr_rename() |>
    relocate_crucial_output_columns()
}

#' Calculate the ICTR indicator
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' @inheritParams ictr_at_product_level
#' @inheritParams ictr_at_company_level
#'
#' @family ICTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' ictr(ictr_companies, ictr_inputs)
ictr <- function(companies, co2, low_threshold = 0.3, high_threshold = 0.7) {
  out <- co2 |>
    ictr_at_product_level(
      low_threshold = low_threshold,
      high_threshold = high_threshold
    ) |>
    ictr_at_company_level(companies)

  out |>
    xctr_rename() |>
    relocate_crucial_output_columns()
}

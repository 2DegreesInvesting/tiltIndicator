#' TODO: Document
#'
#' @family ICTR datasets
#' @examples
#' ictr_inputs
"ictr_inputs"
#' TODO: Document
#'
#' @family ICTR datasets
#' @examples
#' ictr_companies
"ictr_companies"

#' Toy `ictr_inputs`
#'
#' @param input_co2,input_sector,unit See [ictr_inputs].
#' @inheritDotParams tibble::tibble
#'
#' @family ICTR datasets
#'
#' @return A [data.frame].
#' @export
#'
#' @examples
#' ictr_toy_inputs()
#' ictr_toy_inputs(unit = NULL)
#' ictr_toy_inputs(new = 1)
ictr_toy_inputs <- function(input_co2 = 1, input_sector = "a", unit = "u", ...) {
  tibble::tibble(
    input_co2 = input_co2,
    input_sector = input_sector,
    unit = unit,
    ...
  )
}

#' Calculate the ICTR indicator
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [ictr_companies].
#' @param co2 A dataframe like [ictr_inputs].
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#' @param data A dataframe. The output at product level.
#'
#' @family ICTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- ictr_companies
#' co2 <- ictr_inputs
#'
#' # Product level
#' companies |>
#'   ictr_at_product_level(co2)
#'
#' # Company level
#' companies |>
#'   ictr_at_product_level(co2) |>
#'   ictr_at_company_level()
#'
#' # Same
#' ictr(companies, co2)
#' @name ictr
NULL

#' Calculate the PCTR indicator
#'
#' ```{r child=extdata_path("child/intro-pctr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pctr_companies].
#' @param co2 A dataframe like [pctr_ecoinvent_co2].
#' @inheritParams ictr
#'
#' @family PCTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- pctr_companies
#' co2 <- pctr_ecoinvent_co2
#'
#' # Product level
#' companies |>
#'   pctr_at_product_level(co2)
#'
#' # Company level
#' companies |>
#'   pctr_at_product_level(co2) |>
#'   pctr_at_company_level()
#'
#' # Same
#' pctr(companies, co2)
#' @name pctr
NULL

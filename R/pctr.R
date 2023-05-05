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
pctr <- function(companies, co2, low_threshold = 0.3, high_threshold = 0.7) {
  pctr_check(companies)

  companies |>
    pctr_at_product_level(co2, low_threshold, high_threshold) |>
    pctr_at_company_level()
}

#' @rdname pctr
#' @export
pctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 0.3,
                                  high_threshold = 0.7) {
  co2 |>
    rename(tilt_sec = "tilt_sector", isic_sec = "isic_4digit_sector") |>
    xctr_add_ranks(x = "co2_footprint") |>
    rename(tilt_sector = "tilt_sec", isic_4digit_sector = "isic_sec") |>
    xctr_add_scores(low_threshold, high_threshold) |>
    xctr_join_companies(companies) |>
    xctr_polish_output_at_product_level()
}

pctr_check <- function(companies) {
  stopifnot(hasName(companies, "company_id"))
}

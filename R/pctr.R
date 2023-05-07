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
pctr <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  xctr_check(companies, co2)

  companies |>
    pctr_at_product_level(co2, low_threshold, high_threshold) |>
    pctr_at_company_level()
}

#' @rdname pctr
#' @export
pctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1/3,
                                  high_threshold = 2/3) {
  # #230
  co2 <- distinct(co2)
  companies <- distinct(companies)

  out <- co2 |>
    rename(tilt_sec = ends_with("tilt_sector"), unit = ends_with("unit"), isic_sec = ends_with("isic_4digit")) |>
    xctr_add_ranks(col_to_rank(co2)) |>
    xctr_add_scores(low_threshold, high_threshold) |>
    xctr_join_companies(companies) |>
    xctr_polish_output_at_product_level()

  copy_indicator_attribute(co2, out)
}

pctr_check <- function(companies, co2) {
  stopifnot(hasName(companies, "company_id"))
  stopifnot(any(grepl("co2_footprint", names(co2))))
  stopifnot(any(grepl("tilt_sector", names(co2))))
  stopifnot(any(grepl("isic_4digit", names(co2))))
}

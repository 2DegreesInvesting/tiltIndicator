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
ictr <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  xctr_check(companies, co2)

  companies |>
    ictr_at_product_level(co2, low_threshold, high_threshold) |>
    ictr_at_company_level()
}

xctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 1/3,
                                  high_threshold = 2/3) {
  # #230
  co2 <- distinct(co2)
  companies <- distinct(companies)

  out <- co2 |>
    xctr_rename() |>
    xctr_add_ranks(col_to_rank(co2)) |>
    xctr_add_scores(low_threshold, high_threshold) |>
    xctr_join_companies(companies) |>
    xctr_polish_output_at_product_level()

  copy_indicator_attribute(co2, out)
}
#' @rdname ictr
#' @export
ictr_at_product_level <- xctr_at_product_level
pctr_at_product_level <- xctr_at_product_level

stop_if_col_to_rank_has_missing_values <- function(co2) {
  if (anyNA(co2[[col_to_rank(co2)]])) {
    stop(col_to_rank(co2), " can't have missing values.")
  }
}
col_to_rank <- function(co2, pattern = "co2_footprint") {
  find_col(co2, pattern)
}

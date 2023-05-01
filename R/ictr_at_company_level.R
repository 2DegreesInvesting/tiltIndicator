#' Aggregate the input products' scores for each company
#'
#' @description
#' Calculates on a company-level the percentage of input products that are in
#' low / medium / high transition risk due to the input products' relative
#' carbon footprint.
#'
#' Activities are mapped with the companies' input products using common
#' columns.
#'
#' @author Kalash Singhal.
#'
#' @param co2 A [data.frame]. The output of [ictr_at_product_level].
#' @param companies A [data.frame] like [ictr_companies].
#'
#' @family internal-ish functions
#'
#' @return A [data.frame].
#'
#' @export
#'
#' @examples
#' ictr_inputs |>
#'   ictr_at_product_level() |>
#'   ictr_at_company_level(ictr_companies)
ictr_at_company_level <- function(co2, companies) {
  stop_if_any_missing_input_co2(co2)

  xctr_score_companies(
    companies,
    co2,
    uuid = "activity_uuid_product_uuid",
    benchmarks = c("all", "unit", "sector", "unit_sec")
  )
}

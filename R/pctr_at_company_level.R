#' Aggregate the products' scores for each company
#'
#' @description
#' Calculates on a company-level the percentage of products that are in low /
#' medium / high transition risk due to the products' relative carbon footprint.
#'
#' Activities are mapped with the companies' products using common columns.
#'
#' @author Tilman Trompke.
#'
#' @param co2 A [data.frame]. The output of [pctr_at_product_level].
#' @param companies A [data.frame] like [pctr_companies].
#'
#' @family internal-ish functions
#'
#' @return A [data.frame].
#'
#' @export
#'
#' @examples
#' pctr_ecoinvent_co2 |>
#'   pctr_at_product_level() |>
#'   pctr_at_company_level(pctr_companies)
pctr_at_company_level <- function(co2, companies) {
  xctr_score_companies(
    companies,
    co2,
    uuid = "activity_product_uuid",
    benchmarks = c(
      "all",
      "unit",
      # FIXME: Missing "sector" (#191)
      "unit_sec"
    )
  )
}

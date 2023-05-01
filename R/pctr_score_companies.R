#' Aggregate the products' scores for each company
#'
#' @description
#' Calculates on a company-level the percentage of products that are in low /
#' medium / high transition risk due to the products' relative carbon footprint.
#'
#' Activities are mapped with the companies' products using common columns
#' present in dataframes `scored_activities` and `companies`
#'
#' @author Tilman Trompke.
#'
#' @param scored_activities A [data.frame]. The output of
#'   [pctr_score_activities].
#' @param companies A [data.frame] like [pctr_companies].
#'
#' @family PCTR functions
#'
#' @return A [data.frame] with three rows for each company and these columns:
#'   * `company_id`
#'   * `score`
#'   * `share_all`
#'   * `share_unit`
#'   * `share_unit_sec`
#'   where `share_all`, `share_unit`, and `share_unit_sec` holds the
#'   aggregated scores in percentage.
#'
#' @export
#' @keywords internal
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' one_company <- pctr_companies |> filter(company_id %in% first(company_id))
#' one_company
#'
#' pctr_ecoinvent_co2 |>
#'   pctr_score_activities(low_threshold = 0.3, high_threshold = 0.7) |>
#'   pctr_score_companies(one_company)
pctr_score_companies <- function(scored_activities, companies) {
  xctr_score_companies(
    scored_activities,
    companies,
    uuid = "activity_product_uuid",
    benchmarks = c(
      "all",
      "unit",
      # FIXME: Missing "sector" (#191)
      "unit_sec"
    )
  )
}

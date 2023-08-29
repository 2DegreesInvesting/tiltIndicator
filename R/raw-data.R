#' Example raw datasets
#'
#' @return A dataframe.
#' @export
#' @keywords internal
#'
#' @examples
#' example_raw_companies()
#' example_raw_weo()
#' example_raw_ipr()
example_raw_companies <- function() {
  tribble(
  # styler: off
    ~company_id, ~ipr_sector,   ~ipr_subsector, ~weo_sector,   ~weo_subsector,
            "a",  "Industry", "Iron and Steel",     "Total", "Iron and steel",
            "b",  "Industry",      "Chemicals",     "Total",      "Chemicals"
    # styler: on
  )
}

#' @export
#' @rdname example_raw_companies
example_raw_weo <- function() {
  tribble(
    # styler: off
                       ~scenario, ~weo_sector,                               ~weo_subsector, ~year, ~co2_reductions,
      "Stated Policies Scenario",     "Total", "Biofuels production and direct air capture",  2020,               0,
    "Announced Pledges Scenario",     "Total", "Biofuels production and direct air capture",  2020,               0
    # styler: on
  )
}

#' @export
#' @rdname example_raw_companies
example_raw_ipr <- function() {
  tribble(
    # styler: off
    ~scenario, ~ipr_sector, ~ipr_subsector, ~year, ~co2_reductions,
   "1.5C RPS",     "power",             NA,  2030,            0.58,
   "1.5C RPS",     "power",             NA,  2050,            1.06
    # styler: on
  )
}

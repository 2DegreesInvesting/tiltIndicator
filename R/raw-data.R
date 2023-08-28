#' Example raw companies
#'
#' @return A dataframe
#' @export
#' @keywords internal
#'
#' @examples
#' example_raw_companies()
example_raw_companies <- function() {
  tribble(
  # styler: off
    ~company_id, ~ipr_sector,   ~ipr_subsector, ~weo_sector,   ~weo_subsector,
            "a",  "Industry", "Iron and Steel",     "Total", "Iron and steel",
            "b",  "Industry",      "Chemicals",     "Total",      "Chemicals"
    # styler: on
  )
}

example_raw_weo <- function() {
  tribble(
    ~scenario, ~weo_sector, ~weo_subsector, ~year, ~co2_reductions,
    "Stated Policies Scenario", "Total", "Biofuels production and direct air capture", 2020, 0,
    "Announced Pledges Scenario", "Total", "Biofuels production and direct air capture", 2020, 0
  )
}

#' Calculate the indicator "sector profile"
#'
#' ```{r child=extdata_path("child/intro-sector_profile.Rmd")}
#' ```
#'
#' @param companies,scenarios `r document_dataset()`.
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @template example-sector_profile
sector_profile <- function(companies,
                           scenarios,
                           low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                           high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- sector_profile_at_product_level(companies, scenarios, low_threshold, high_threshold)
  company <- epa_at_company_level(product) |>
    insert_row_with_na_in_risk_category()

  tilt_profile(nest_levels(product, company))
}

example_sector <- function() {
  arrange_for_easier_comparison_in_the_console <- function(data) {
    cols <- rlang::exprs(type, sector, subsector)
    arrange(relocate(data, !!!cols), !!!cols)
  }

  # styler: off
  # The arrangement here is for identical match with the example here:
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064
  list(
    companies = tribble(
      ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
                "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
                "a",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
                "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
                "a",        "c",                 "unmatched",          "c",             "c",       "ipr",  "land use",  "land use",
                "a",        "c",                 "unmatched",          "c",             "c",       "weo",          NA,          NA
    ) |> arrange_for_easier_comparison_in_the_console(),
    scenarios = tribble(
         ~sector, ~subsector, ~year, ~reductions, ~type, ~scenario,
         "total",   "energy",  2050,           1, "ipr",       "a",
         "total",   "energy",  2050,         0.6, "weo",       "a",
      "land use", "land use",  2050,         0.3, "ipr",       "a"
    ) |> arrange_for_easier_comparison_in_the_console()
  )
  # styler: off
}
example_sector_companies <- example_data_factory(example_sector()[["companies"]])
example_sector_scenarios <- example_data_factory(example_sector()[["scenarios"]])

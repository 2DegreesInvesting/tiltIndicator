#' ---
#' output:
#'   reprex::reprex_document:
#'     advertise: FALSE
#' ---

#' <details/><summary/>reprex</summary>

# styler: off
companies <- tibble::tribble(
      ~sector, ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~subsector, ~tilt_sector, ~tilt_subsector, ~type,
  "unmatched",           "a",        "a",                         "a",   "energy",          "a",             "a", "ipr"
)
scenarios <- tibble::tribble(
  ~sector, ~subsector,  ~year, ~reductions, ~type, ~scenario,
  "total",   "energy", "2050",         "1", "ipr",       "a"
)

# styler: on

if (!interactive()) withr::local_options(width = 500)



# Load code in the main branch
library(tiltIndicator)
packageVersion("tiltIndicator")

result_main <- sector_profile(companies, scenarios)

result_main |> unnest_product()

result_main |> unnest_company()

# Compare ----------------------------------------------------------------

# Load code in this PR
devtools::load_all()
packageVersion("tiltIndicator")

result_pr <- sector_profile(companies, scenarios)

result_pr |> unnest_product()

result_pr |> unnest_company()

#' </details>

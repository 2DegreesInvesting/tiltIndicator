example_raw_companies <- function() {
  tribble(
  # styler: off
    ~company_id, ~ipr_sector,   ~ipr_subsector, ~weo_sector,   ~weo_subsector,
            "a",  "Industry", "Iron and Steel",     "Total", "Iron and steel",
            "b",  "Industry",      "Chemicals",     "Total",      "Chemicals"
  # styler: on
  )
}

test_that("outputs the expected columns", {
  # styler: off
  pstr <- tribble(
    ~companies_id,                              ~grouped_by, ~risk_category, ~value,
    "fleischerei-stiefsohn_00000005219477-001", "ipr_1.5c required policy scenario_2020",         "high",      0,
    "fleischerei-stiefsohn_00000005219477-001", "ipr_1.5c required policy scenario_2020",       "medium",      0,
    "fleischerei-stiefsohn_00000005219477-001", "ipr_1.5c required policy scenario_2020",          "low",      1
  )
  # styler: on
  out <- pstr_polish_output_at_copmany_level(pstr)
  exp <- c("companies_id", "type", "scenario", "year", "risk_category", "value")
  expect_named(out, exp)
})

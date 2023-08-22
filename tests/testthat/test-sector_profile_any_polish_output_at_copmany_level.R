test_that("outputs the expected columns", {
  # styler: off
  pstr <- tribble(
    ~companies_id,           ~grouped_by, ~risk_category, ~value,
              "a", "ipr_some thing_2020",         "high",      0,
              "a", "ipr_some thing_2020",       "medium",      0,
              "a", "ipr_some thing_2020",          "low",      1
  )
  # styler: on

  out <- sector_profile_any_polish_output_at_company_level(pstr)

  exp <- c("companies_id", "type", "scenario", "year", "risk_category", "value")
  expect_named(out, exp)
})

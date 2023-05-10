test_that("outputs expected columns at product level", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)

  expected <- c(
    "companies_id",
    "grouped_by",
    "risk_category",
    "clustered",
    "activity_uuid_product_uuid",
    "tilt_sector",
    "tilt_subsector",
    "scenario",
    "year",
    "type"
  )
  out <- pstr_at_product_level(companies, scenarios)
  expect_named(out, expected)
})

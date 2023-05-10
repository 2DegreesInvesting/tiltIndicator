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
    # FIXME rename to scenario
    "type",
    "year"
  )
  out <- pstr_at_product_level(companies, scenarios)
  # FIXME: Implement
  # out <- out |> select(all_of(expected))
  expect_named(out, expected)
})

test_that("snapshot", {
  companies <- example_raw_companies()
  out <- sector_profile_any_pivot_type_sector_subsector(companies)
  expect_snapshot(format_robust_snapshot(out))
})

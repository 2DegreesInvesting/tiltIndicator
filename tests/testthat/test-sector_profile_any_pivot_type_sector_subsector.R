test_that("snapshot", {
  companies <- read_test_csv(extdata_path("raw_sector_profile_companies.csv"))
  out <- sector_profile_any_pivot_type_sector_subsector(companies)
  expect_snapshot(format_robust_snapshot(out))
})

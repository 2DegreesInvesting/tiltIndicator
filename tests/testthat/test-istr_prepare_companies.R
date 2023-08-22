test_that("snapshot", {
  companies <- read_test_csv(extdata_path("istr_companies.csv"))
  expect_snapshot(format_robust_snapshot(companies))
})

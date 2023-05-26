test_that("snapshot", {
  withr::local_options(list(readr.show_col_types = FALSE))
  companies <- slice(read_csv(extdata_path("istr_companies.csv")), 1)
  expect_snapshot(format_robust_snapshot(companies))
})

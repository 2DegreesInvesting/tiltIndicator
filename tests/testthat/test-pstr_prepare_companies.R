test_that("snapshot", {
  withr::local_options(list(readr.show_col_types = FALSE))

  companies <- slice(readr::read_csv(extdata_path("pstr_raw_companies.csv")), 1)
  out <- pstr_prepare_companies(companies)
  expect_snapshot(format_robust_snapshot(out))
})

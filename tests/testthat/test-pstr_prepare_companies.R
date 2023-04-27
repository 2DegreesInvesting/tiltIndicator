test_that("snapshot", {
  companies <- slice(pstr_new_companies, 1)
  out <- pstr_prepare_companies(companies)
  expect_snapshot(format_robust_snapshot(out))
})

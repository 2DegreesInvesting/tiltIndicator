test_that("outputs expected columns at product level", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)
  out <- pstr_at_product_level(companies, scenarios)
  expect_named(out, pstr_cols_at_product_level())
})

test_that("the thresholds are in the range 0 to 1", {
  pstr_arguments <- formals(pstr_at_product_level)

  low_threshold <- eval(pstr_arguments$low_threshold)
  high_threshold <- eval(pstr_arguments$high_threshold)

  expect_true(low_threshold >= 0 & low_threshold <= 1)
  expect_true(high_threshold >= 0 & high_threshold <= 1)
})

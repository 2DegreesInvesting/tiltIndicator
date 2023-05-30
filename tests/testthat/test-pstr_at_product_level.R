test_that("outputs expected columns at product level", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)
  out <- pstr_at_product_level(companies, scenarios)
  expect_named(out, pstr_cols_at_product_level())
})

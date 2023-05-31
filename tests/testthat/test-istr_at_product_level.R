test_that("outputs expected columns at product level", {
  companies <- slice(istr_companies, 1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs
  out <- istr_at_product_level(companies, scenarios, inputs)
  expect_named(out, istr_cols_at_product_level())
})

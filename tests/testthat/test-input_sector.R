test_that("wraps the output at product and company levels", {
  companies <- slice(istr_companies, 3)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  out <- input_sector(companies, scenarios, inputs)

  product <- unnest_product(out)
  expect_equal(product, istr_at_product_level(companies, scenarios, inputs))

  company <- unnest_company(out)
  expected <- istr_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

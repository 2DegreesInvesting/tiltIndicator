test_that("wraps the output at product and company levels", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios)

  product <- unnest_product(out)
  expect_equal(product, sector_profile_at_product_level(companies, scenarios))

  company <- unnest_company(out)
  expected <- any_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("wraps the output at product and company levels", {
  out <- emissions_profile_upstream(companies, inputs)

  product <- unnest_product(out)
  expect_equal(product, xctr_at_product_level(companies, inputs))

  company <- unnest_company(out)
  expected <- xctr_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("wraps the output at product and company levels", {
  out <- x_carbon(companies, products)

  product <- unnest_product(out)
  expect_equal(product, xctr_at_product_level(companies, products))

  company <- unnest_company(out)
  expected <- xctr_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

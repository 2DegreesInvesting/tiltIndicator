test_that("wraps the output at product and company levels", {
  out <- emissions_profile(companies, products)

  product <- unnest_product(out)
  expect_equal(product, xctr_at_product_level(companies, products))

  company <- unnest_company(out)
  expected <- xctr_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("xctr() with products outputs the same with a deprecation warning", {
  expect_warning(
    expect_equal(
      xctr(companies, products),
      emissions_profile(companies, products)
    ),
    "emissions_profile"
  )
})

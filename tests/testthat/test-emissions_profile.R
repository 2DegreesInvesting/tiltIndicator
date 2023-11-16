test_that("wraps the output at product and company levels", {
  out <- emissions_profile(companies, products)

  product <- unnest_product(out)
  expect_equal(product, emissions_profile_any_at_product_level(companies, products))

  company <- unnest_company(out)
  expected <- any_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("xctr() with products yields the same with a deprecation warning", {
  expect_warning(
    expect_equal(
      xctr(companies, products),
      emissions_profile(companies, products)
    ),
    "emissions_profile"
  )
})

test_that("*upstream() wraps the output at product and company levels", {
  out <- emissions_profile_upstream(companies, inputs)

  product <- unnest_product(out)
  expect_equal(product, emissions_profile_any_at_product_level(companies, inputs))

  company <- unnest_company(out)
  expected <- any_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("xctr() with inputs yields the same as *upstream() with a deprecation warning", {
  expect_warning(
    expect_equal(
      xctr(companies, inputs),
      emissions_profile_upstream(companies, inputs)
    ),
    # This is close enough to "emissions_profile_upstream"
    "emissions_profile"
  )
})

test_that("accepts `companies_id` (#564)", {
  companies <- example_companies() |> dplyr::rename(companies_id = company_id)
  co2 <- example_products()
  expect_no_error(emissions_profile(companies, co2))
})

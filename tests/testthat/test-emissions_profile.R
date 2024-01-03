test_that("hasn't change", {
  skip_if_toy_data_is_old()

  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- read_test_csv(toy_emissions_profile_products_ecoinvent(), n_max = 8)

  out <- emissions_profile(companies, inputs)
  expect_snapshot(format_robust_snapshot(unnest_product(out)))
  expect_snapshot(format_robust_snapshot(unnest_company(out)))
})

test_that("wraps the output at product and company levels", {
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  products <- read_test_csv(toy_emissions_profile_products())

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
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  products <- read_test_csv(toy_emissions_profile_products())

  expect_warning(
    expect_equal(
      xctr(companies, products),
      emissions_profile(companies, products)
    ),
    "emissions_profile"
  )
})

test_that("*upstream() wraps the output at product and company levels", {
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- read_test_csv(toy_emissions_profile_upstream_products())

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
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- read_test_csv(toy_emissions_profile_upstream_products())

  expect_warning(
    expect_equal(
      xctr(companies, inputs),
      emissions_profile_upstream(companies, inputs)
    ),
    # This is close enough to "emissions_profile_upstream"
    "emissions_profile"
  )
})

test_that("accepts `company_id` with a warning (#564)", {
  companies <- example_companies() |> rename(company_id = companies_id)
  co2 <- example_products()

  expect_no_error(
    expect_warning(
      emissions_profile(companies, co2),
      class = "rename_id"
    )
  )
})

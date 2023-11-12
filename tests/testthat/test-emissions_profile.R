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

test_that("it uses pre-computed `values_to_categorize` from 'co2' (#603)", {
  companies <- example_companies()
  co2 <- example_products(
    !!aka("uid") := c("a", "b"),
    !!aka("co2footprint") := c(1, 2)
  )

  lacks_values_to_categorize <- !hasName(co2, "values_to_categorize")
  stopifnot(lacks_values_to_categorize)
  out1 <- emissions_profile(companies, co2)
  using_computed_values <- unique(unnest_product(out1)$risk_category)

  pre_computed <- emissions_profile_any_add_values_to_categorize(co2)
  has_values_to_categorize <- hasName(pre_computed, "values_to_categorize")
  stopifnot(has_values_to_categorize)

  yields_a_different_risk_category <- 999
  pre_computed$values_to_categorize <- yields_a_different_risk_category
  out2 <- emissions_profile(companies, pre_computed)
  using_pre_computed_values <- unique(unnest_product(out2)$risk_category)

  expect_false(identical(using_computed_values, using_pre_computed_values))
})

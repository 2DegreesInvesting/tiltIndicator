test_that("wraps the output at product and company levels", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  out <- sector_profile_upstream(companies, scenarios, inputs)

  product <- unnest_product(out)
  expect_equal(product, sector_profile_upstream_at_product_level(companies, scenarios, inputs))

  company <- unnest_company(out)
  expected <- any_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("istr() yields the same with a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  expect_warning(
    expect_equal(
      istr(companies, scenarios, inputs),
      sector_profile_upstream(companies, scenarios, inputs)
    ),
    "sector_profile_upstream"
  )
})

test_that("accepts `companies_id` (#564)", {
  companies <- example_companies() |> rename(companies_id = company_id)
  scenarios <- example_scenarios()
  expect_no_error(sector_profile(companies, scenarios))
})

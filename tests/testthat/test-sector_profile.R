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

test_that("pstr() yields the same with deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  expect_warning(
    expect_equal(
      pstr(companies, scenarios),
      sector_profile(companies, scenarios)
    ),
    "sector_profile"
  )
})

test_that("accepts `companies_id` (#564)", {
  companies <- example_companies() |> rename(companies_id = company_id)
  scenarios <- example_scenarios()
  expect_no_error(sector_profile(companies, scenarios))
})

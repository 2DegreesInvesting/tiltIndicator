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

test_that("accepts `company_id` with a warning (#564)", {
  companies <- example_companies() |> rename(company_id = companies_id)
  inputs <- example_inputs()
  scenarios <- example_scenarios()

  expect_no_error(
    expect_warning(
      sector_profile_upstream(companies, scenarios, inputs),
      class = "rename_id"
    )
  )
})

test_that("wraps the output at product and company levels", {
  companies <- read_test_csv(toy_sector_profile_upstream_companies(), n_max = 3)
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios(), n_max = Inf)
  inputs <- read_test_csv(toy_sector_profile_upstream_products(), n_max = Inf)

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
  companies <- read_test_csv(toy_sector_profile_upstream_companies(), n_max = 3)
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios(), n_max = Inf)
  inputs <- read_test_csv(toy_sector_profile_upstream_products(), n_max = Inf)

  expect_warning(
    expect_equal(
      istr(companies, scenarios, inputs),
      sector_profile_upstream(companies, scenarios, inputs)
    ),
    "sector_profile_upstream"
  )
})

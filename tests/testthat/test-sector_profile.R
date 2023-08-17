test_that("wraps the output at product and company levels", {
  companies <- pstr_companies
  scenarios <- xstr_scenarios

  out <- sector_profile(companies, scenarios)

  product <- unnest_product(out)
  expect_equal(product, spi_product(companies, scenarios))

  company <- unnest_company(out)
  expected <- spi_company(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
})

test_that("pstr() yields the same with deprecation warning", {
  companies <- pstr_companies
  scenarios <- xstr_scenarios

  expect_warning(
    expect_equal(
      pstr(companies, scenarios),
      sector_profile(companies, scenarios)
    ),
    "sector_profile"
  )
})

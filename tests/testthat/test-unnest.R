test_that("unnests", {
  companies <- read_test_csv(toy_sector_profile_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios(), n_max = Inf)

  out <- sector_profile(companies, scenarios)

  expect_equal(
    unnest_product(out),
    unnest(select(out, -"company"), "product")
  )

  expect_equal(
    unnest_company(out),
    unnest(select(out, -"product"), "company")
  )
})

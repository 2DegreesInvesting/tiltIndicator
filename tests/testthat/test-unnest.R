test_that("unnests", {
  companies <- example_companies()
  scenarios <- example_scenarios()

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

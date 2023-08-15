test_that("unnests", {
  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios

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

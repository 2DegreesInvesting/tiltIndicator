test_that("unnests", {
  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios

  out <- product_sector(companies, scenarios)

  expect_equal(
    unnest_product(out),
    unnest(select(out, -"company"), "product")
  )
})

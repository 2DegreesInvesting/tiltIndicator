test_that("pctr_at_product_level returns visibly (#238)", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)
  expect_visible(pctr_at_product_level(companies, co2))
})

test_that("pctr_at_product_level returns visibly (#238)", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)
  expect_visible(xctr_at_product_level(companies, co2))
})

test_that("outputs expected columns at product level", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)

  out <- xctr_at_product_level(companies, co2)

  expected <- c(cols_at_product_level(), "co2_footprint")
  expect_named(out, expected)
})

test_that("returns visibly (#238)", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(ictr_inputs, 1)
  expect_visible(ictr_at_product_level(companies, co2))
})

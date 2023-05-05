test_that("returns visibly (#238)", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(ictr_inputs, 1)
  expect_visible(ictr_at_product_level(companies, co2))
})

test_that("outputs expected columns at product level", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(ictr_inputs, 1)

  out <- ictr_at_product_level(companies, co2)

  expected <- cols_at_product_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

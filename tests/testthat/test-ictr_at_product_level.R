test_that("returns visibly (#238)", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(ictr_inputs, 1)
  expect_visible(ictr_at_product_level(companies, co2))
})

test_that("outputs expected columns at product level", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(ictr_inputs, 1)

  out <- ictr_at_product_level(companies, co2)

  expected <- c(
    cols_at_product_level(),
    "input_activity_uuid_product_uuid",
    "input_co2_footprint"
  )
  expect_named(out, expected)
})

test_that("outputs an object of class ictr", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(ictr_inputs, 1)
  out <- ictr_at_product_level(companies, co2)
  expect_equal(attributes(out)$indicator, "ictr")
})

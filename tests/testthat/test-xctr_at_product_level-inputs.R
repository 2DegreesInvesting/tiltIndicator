test_that("returns visibly (#238)", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(inputs, 1)
  expect_visible(xctr_at_product_level(companies, co2))
})

test_that("outputs expected columns at product level", {
  companies <- slice(ictr_companies, 1)
  co2 <- slice(inputs, 1)

  out <- xctr_at_product_level(companies, co2)

  expected <- c(
    cols_at_product_level(),
    "input_activity_uuid_product_uuid",
    "input_co2_footprint"
  )
  expect_named(out, expected)
})

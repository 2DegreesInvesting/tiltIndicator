test_that("returns visibly (#238)", {
  companies <- slice(companies, 1)
  co2 <- slice(products, 1)
  expect_visible(xctr_at_product_level(companies, co2))
})

test_that("outputs expected columns at product level", {
  companies <- slice(companies, 1)
  co2 <- slice(products, 1)

  out <- xctr_at_product_level(companies, co2)

  expected <- c(cols_at_product_level(), "co2_footprint")
  expect_named(out, expected)
})

test_that("unmatched products don't introduce NA's (#266)", {
  companies <- tibble(
    company_id = "x",
    activity_uuid_product_uuid = c("a", "b"),
    clustered = c("1", "2")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = c("a"),
    input_activity_uuid_product_uuid = c("m"),
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )
  out <- xctr_at_product_level(companies, inputs)
  expect_false(anyNA(out$risk_category))
})

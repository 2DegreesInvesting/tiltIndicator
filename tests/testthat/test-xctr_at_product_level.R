test_that("returns visibly (#238)", {
  companies <- slice(companies, 1)

  inputs <- slice(inputs, 1)
  expect_visible(xctr_at_product_level(companies, inputs))
  products <- slice(products, 1)
  expect_visible(xctr_at_product_level(companies, products))
})

test_that("outputs expected columns at product level", {
  companies <- slice(companies, 1)

  inputs <- slice(inputs, 1)
  expected <- c(
    cols_at_product_level(),
    "input_activity_uuid_product_uuid",
    "input_co2_footprint"
  )
  out <- xctr_at_product_level(companies, inputs)
  expect_named(out, expected)

  products <- slice(products, 1)
  expected <- c(cols_at_product_level(), "co2_footprint")
  out <- xctr_at_product_level(companies, products)
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

  products <- tibble(
    activity_uuid_product_uuid = c("a"),
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    isic_4digit = "4575"
  )
  out <- xctr_at_product_level(companies, products)
  expect_false(anyNA(out$risk_category))
})

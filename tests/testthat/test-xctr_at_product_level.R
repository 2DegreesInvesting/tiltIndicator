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

test_that("some match yield no NA and no match yields 1 row with `NA`s (#393)", {
  companies <- tibble(
    company_id = c("a", "a", "b", "b"),
    activity_uuid_product_uuid = c("matched", paste0("unmatched", 1:3)),
    clustered = "a"
  )
  products <- tibble(
    activity_uuid_product_uuid = "matched",
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    isic_4digit = "a"
  )

  out <- xctr_at_product_level(companies, products)

  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  na_cols <- setdiff(cols_at_product_level(), "companies_id")
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)
})

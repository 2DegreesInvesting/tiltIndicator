test_that("hasn't change", {
  out <- xctr_at_product_level(companies, inputs) |>
    xctr_at_company_level() |>
    dplyr::arrange(companies_id) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("outputs expected columns at company level", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  out <- xctr_at_product_level(companies, inputs) |>
    xctr_at_company_level()

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("it's arranged by `companies_id` and `grouped_by`", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  out <- xctr_at_product_level(companies, inputs) |>
    xctr_at_company_level()

  expect_equal(out, arrange(out, companies_id, grouped_by))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1:2)
  out1 <- xctr_at_product_level(companies, inputs, low_threshold = .1) |>
    xctr_at_company_level()
  out2 <- xctr_at_product_level(companies, inputs, low_threshold = .9) |>
    xctr_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1:2)
  out1 <- xctr_at_product_level(companies, inputs, high_threshold = .1) |>
    xctr_at_company_level()
  out2 <- xctr_at_product_level(companies, inputs, high_threshold = .9) |>
    xctr_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("for a company with 3 products of varying footprints, value is 1/3 (#243)", {
  # > Adjusting the risk thresholds to 1/3 and 2/3
  low_threshold <- 1 / 3
  high_threshold <- 2 / 3
  # > If we have a company with 3 products varying in their co2_footprint
  three_products <- c("x", "y", "z")
  varying_co2_footprint <- 1:3
  # > Then the company should have values of 1/3 per risk category
  expected_value <- 1 / 3

  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = three_products,
  )
  co2 <- tibble(
    activity_uuid_product_uuid = three_products,
    input_co2_footprint = varying_co2_footprint,
    input_activity_uuid_product_uuid = "c",
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575",
  )

  product <- xctr_at_product_level(companies, co2, low_threshold, high_threshold)
  out <- xctr_at_company_level(product)
  expect_true(identical(unique(out$value), expected_value))
})

test_that("values sum 1", {
  companies <- tibble(
    activity_uuid_product_uuid = "a",
    company_id = "a",
    clustered = "a"
  )
  co2 <- tibble(
    activity_uuid_product_uuid = "a",
    input_co2_footprint = 1,
    input_tilt_sector = "a",
    input_unit = "a",
    input_isic_4digit = "a"
  )

  out <- xctr_at_product_level(companies, co2) |>
    xctr_at_company_level()

  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- tibble(
    activity_uuid_product_uuid = "unmatched",
    company_id = "a",
    clustered = "a"
  )
  co2 <- tibble(
    activity_uuid_product_uuid = "a",
    input_co2_footprint = 1,
    input_tilt_sector = "a",
    input_unit = "a",
    input_isic_4digit = "a"
  )

  out <- xctr_at_product_level(companies, co2) |>
    xctr_at_company_level()

  expect_equal(out$companies_id, "a")
  expect_equal(out$grouped_by, NA_character_)
  expect_equal(out$risk_category, NA_character_)
  expect_equal(out$value, NA_real_)
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- tibble(
    activity_uuid_product_uuid = c("a", "unmatched"),
    company_id = "a",
    clustered = "a"
  )
  co2 <- tibble(
    activity_uuid_product_uuid = "a",
    input_co2_footprint = 1,
    input_tilt_sector = "a",
    input_unit = "a",
    input_isic_4digit = "a"
  )

  out <- xctr_at_product_level(companies, co2) |>
    xctr_at_company_level()

  expect_equal(nrow(out), 18L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 18L)
  expect_false(anyNA(out))
})

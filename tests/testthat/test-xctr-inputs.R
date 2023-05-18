test_that("hasn't change", {
  out <- xctr(companies, inputs) |>
    dplyr::arrange(companies_id) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("outputs expected columns at company level", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  out <- xctr(companies, inputs)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("it's arranged by `companies_id` and `grouped_by`", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  out <- xctr(companies, inputs)

  expect_equal(out, arrange(out, companies_id, grouped_by))
})

test_that("returns n rows equal to companies x risk_category x grouped_by", {
  inputs <- tibble(
    activity_uuid_product_uuid = "x",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )

  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = c("x", "y"),
    clustered = c("xyz", "abc")
  )
  out <- xctr(companies, inputs)

  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))

  companies <- tibble(
    company_id = c("a", "b"),
    activity_uuid_product_uuid = c("x", "y"),
    clustered = c("xyz", "abc")
  )
  out <- xctr(companies, inputs)
  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))
})

test_that("if a company matches at least one input, each share sums 1 (#175)", {
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = c("a", "b"),
    clustered = c("xyz", "abc")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = c("a"),
    input_activity_uuid_product_uuid = c("y"),
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )

  out <- xctr(companies, inputs)
  sum_of_each_share <- out |>
    group_by(grouped_by) |>
    summarize(sum = sum(value)) |>
    distinct(sum) |>
    pull()
  expect_equal(sum_of_each_share, 1)
})

test_that("if a company matches no inputs, all shares are `NA` (#176)", {
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = "a",
    clustered = "xyz"
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "b",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )

  out <- xctr(companies, inputs)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches no inputs, all shares are `NA` (#176)", {
  companies <- tibble(
    company_id = c("a"),
    activity_uuid_product_uuid = c("a"),
    clustered = c("xyz")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "b",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )

  out <- xctr(companies, inputs)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches at least one input, no share is `NA` (#176)", {
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = c("a", "b"),
    clustered = c("xyz", "abc")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "a",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )

  out <- xctr(companies, inputs)
  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_false(any(share_is_na))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1:2)
  out1 <- xctr(companies, inputs, low_threshold = .1)
  out2 <- xctr(companies, inputs, low_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1:2)
  out1 <- xctr(companies, inputs, high_threshold = .1)
  out2 <- xctr(companies, inputs, high_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr(bad, inputs), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr(bad, inputs), crucial)
})

test_that("if `inputs` lacks crucial columns, errors gracefully", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(inputs, -all_of(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "co2_footprint"
  bad <- select(inputs, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "unit"
  bad <- select(inputs, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "tilt_sector"
  bad <- select(inputs, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "isic_4digit"
  bad <- select(inputs, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)
})

test_that("with a missing value in the co2* column errors gracefully", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  inputs$input_co2_footprint <- NA
  expect_error(xctr(companies, inputs), "co2_footprint")
})

test_that("handles duplicated `companies` data (#230)", {
  companies <- tibble(
    company_id = rep("a", 2),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = c("c"),
    input_activity_uuid_product_uuid = "d",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )
  expect_no_error(xctr(companies, co2))
})

test_that("handles duplicated `co2` data (#230)", {
  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = rep("c", 2),
    input_activity_uuid_product_uuid = "d",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )
  expect_no_error(xctr(companies, co2))
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

  out <- xctr(companies, co2, low_threshold, high_threshold)
  expect_true(identical(unique(out$value), expected_value))
})

test_that("a 0-row `companies` yields an error", {
  expect_error(
    xctr(companies[0L, ], inputs),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `inputs` yields an error", {
  expect_error(
    xctr(slice(companies, 1), inputs[0L, ]),
    "co2.*can't have 0-row"
  )
})

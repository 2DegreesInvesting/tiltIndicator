test_that("hasn't change", {
  out <- format_robust_snapshot(ictr(ictr_companies, ictr_inputs))
  expect_snapshot(out)
})

test_that("outputs common output columns", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)

  out <- ictr(companies, inputs)

  expected <- cols_at_company_level()
  expect_equal(names(out)[1:4], expected)
})

test_that("it's arranged by `companies_id` and `grouped_by`", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)

  out <- ictr(companies, inputs)

  expect_equal(out, arrange(out, companies_id, grouped_by))
})

test_that("returns n rows equal to companies x risk_category x grouped_by", {
  inputs <- tibble(
    activity_uuid_product_uuid = "x",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit_sector = 4575
  )

  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = c("x", "y")
  )
  out <- ictr(companies, inputs)

  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))

  companies <- tibble(
    company_id = c("a", "b"),
    activity_uuid_product_uuid = c("x", "y")
  )
  out <- ictr(companies, inputs)
  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))
})

test_that("if a company matches at least one input, each share sums 1 (#175)", {
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = c("a", "b")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = c("a"),
    input_activity_uuid_product_uuid = c("y"),
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit_sector = 4575
  )

  out <- ictr(companies, inputs)
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
    activity_uuid_product_uuid = "a"
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "b",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit_sector = 4575
  )

  out <- ictr(companies, inputs)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches no inputs, all shares are `NA` (#176)", {
  companies <- tibble(
    company_id = c("a"),
    activity_uuid_product_uuid = c("a")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "b",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit_sector = 4575
  )

  out <- ictr(companies, inputs)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches at least one input, no share is `NA` (#176)", {
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = c("a", "b")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "a",
    input_activity_uuid_product_uuid = "y",
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit_sector = 4575
  )

  out <- ictr(companies, inputs)
  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_false(any(share_is_na))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1:2)
  out1 <- ictr(companies, inputs, low_threshold = .1)
  out2 <- ictr(companies, inputs, low_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1:2)
  out1 <- ictr(companies, inputs, high_threshold = .1)
  out2 <- ictr(companies, inputs, high_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(ictr(bad, inputs), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(ictr(bad, inputs), crucial)
})

test_that("if `inputs` lacks crucial columns, errors gracefully", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(inputs, -all_of(crucial))
  expect_error(ictr(companies, bad), crucial)

  crucial <- "input_co2_footprint"
  bad <- select(inputs, -all_of(crucial))
  expect_error(ictr(companies, bad), crucial)

  crucial <- "input_unit"
  bad <- select(inputs, -all_of(crucial))
  expect_error(ictr(companies, bad), crucial)
})

test_that("with a missing value in `inputs$inputs_co2` errors gracefully", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)
  inputs$input_co2_footprint <- NA
  expect_error(ictr(companies, inputs), "input_co2_footprint.*missing")
})

test_that("if `inputs` has 0-rows, the output is normal (shares are NA)", {
  companies <- slice(ictr_companies, 1)

  inputs0 <- ictr_inputs[0, ]
  inputs1 <- ictr_inputs[1, ]
  out0 <- ictr(companies, inputs0)
  out1 <- ictr(companies, inputs1)

  expect_s3_class(out0, "tbl_df")
  expect_equal(names(out0), names(out1))
  expect_equal(nrow(out0), nrow(out1))
})

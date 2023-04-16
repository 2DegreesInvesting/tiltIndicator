test_that("with minimal data outptus a tibble", {
  data <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr_score_activities(data)
  expect_s3_class(out, "tbl_df")
})

test_that("with 0-row data returns 0-row tibble", {
  data <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr_score_activities(data[0, ])
  expect_equal(nrow(out), 0L)
  expect_s3_class(out, "tbl_df")
})

test_that("with n rows outputs n rows", {
  data <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr_score_activities(data)
  expect_equal(nrow(out), 1L)

  data <- slice(pctr_ecoinvent_co2, 1:3)
  out <- pctr_score_activities(data)
  expect_equal(nrow(out), 3L)
})

test_that("outputs 11 columns plus any non crucial column", {
  data <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr_score_activities(data)
  expect_equal(ncol(out), 11L)

  data <- slice(pctr_ecoinvent_co2, 1) |> mutate(new = 1)
  out <- pctr_score_activities(data)
  expect_equal(ncol(out), 12L)
  expect_true(hasName(out, "new"))
})

test_that("without crucial data errors gracefully", {
  expect_error(pctr_score_activities(), "missing")
})

test_that("without crucial columns errors gracefully", {
  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    select(-"sec")
  expect_error(pctr_score_activities(data), "sec.*not found")

  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    select(-"unit")
  expect_error(pctr_score_activities(data), "unit.*not found")

  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    select(-"co2_footprint")
  expect_error(pctr_score_activities(data), "co2_footprint.*not found")
})

test_that("is sensitive to low_threshold with 2 or more input rows but not 1", {
  data <- pctr_ecoinvent_co2 |> slice(1:2)
  out1 <- pctr_score_activities(data, low_threshold = .1)
  out2 <- pctr_score_activities(data, low_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- pctr_ecoinvent_co2 |> slice(1)
  out1 <- pctr_score_activities(data, low_threshold = .1)
  out2 <- pctr_score_activities(data, low_threshold = .9)
  expect_true(identical(out1, out2))
})

test_that("is sensitive to high_threshold with 2 or more input rows but not 1", {
  data <- pctr_ecoinvent_co2 |> slice(1:2)
  out1 <- pctr_score_activities(data, high_threshold = .1)
  out2 <- pctr_score_activities(data, high_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- pctr_ecoinvent_co2 |> slice(1)
  out1 <- pctr_score_activities(data, high_threshold = .1)
  out2 <- pctr_score_activities(data, high_threshold = .9)
  expect_true(identical(out1, out2))
})

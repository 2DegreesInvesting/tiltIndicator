test_that("hasn't change", {
  out <- ictr_score_inputs(ictr_inputs) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("with minimal data outptus a tibble", {
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  expect_s3_class(ictr_score_inputs(data), "tbl_df")
})

test_that("handles 0-row inputs", {
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")[0, ]
  expect_s3_class(ictr_score_inputs(data), "tbl_df")
})

test_that("with n rows outputs n rows", {
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  out <- ictr_score_inputs(data)
  expect_equal(nrow(out), 1L)
  data <- tibble(input_co2 = 1:3, input_sector = "a", unit = "u")
  out <- ictr_score_inputs(data)
  expect_equal(nrow(out), 3L)
})

test_that("outputs 11 columns plus any non crucial column", {
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 11L)

  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u", new = 1)
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 12L)
  expect_true(hasName(out, "new"))
})

test_that("without crucial data errors gracefully", {
  expect_error(ictr_score_inputs(), "missing")
})

test_that("without crucial columns errors gracefully", {
  data <- tibble(input_sector = "a", unit = "u")
  expect_error(ictr_score_inputs(data), "input_co2.*not found")

  data <- tibble(input_co2 = 1, unit = "u")
  expect_error(ictr_score_inputs(data), "input_sector.*not found")

  data <- tibble(input_co2 = 1, input_sector = "a")
  expect_error(ictr_score_inputs(data), "unit.*not found")
})

test_that("is sensitive to low_threshold with 2 or more input rows but not 1", {
  data <- tibble(input_co2 = 1:2, input_sector = "a", unit = "u")
  out1 <- ictr_score_inputs(data, low_threshold = .1)
  out2 <- ictr_score_inputs(data, low_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  out1 <- ictr_score_inputs(data, low_threshold = .1)
  out2 <- ictr_score_inputs(data, low_threshold = .9)
  expect_true(identical(out1, out2))
})

test_that("is sensitive to high_threshold with 2 or more input rows but not 1", {
  data <- tibble(input_co2 = 1:2, input_sector = "a", unit = "u")
  out1 <- ictr_score_inputs(data, high_threshold = .1)
  out2 <- ictr_score_inputs(data, high_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  out1 <- ictr_score_inputs(data, high_threshold = .1)
  out2 <- ictr_score_inputs(data, high_threshold = .9)
  expect_true(identical(out1, out2))
})

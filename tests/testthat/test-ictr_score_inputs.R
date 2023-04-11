test_that("hasn't change", {
  out <- ictr_score_inputs(ictr_inputs) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("with minimal data outptus a tibble", {
  data <- ictr_toy_inputs()
  expect_s3_class(ictr_score_inputs(data), "tbl_df")
})

test_that("handles 0-row inputs", {
  data <- ictr_toy_inputs()[0, ]
  expect_s3_class(ictr_score_inputs(data), "tbl_df")
})

test_that("with n rows outputs n rows", {
  out <- ictr_score_inputs(ictr_toy_inputs())
  expect_equal(nrow(out), 1L)
  out <- ictr_score_inputs(ictr_toy_inputs(c(1, 1, 1)))
  expect_equal(nrow(out), 3L)
})

test_that("outputs 11 columns plus any non crucial column", {
  data <- ictr_toy_inputs()
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 11L)

  data <- ictr_toy_inputs(new = 1)
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 12L)
  expect_true(hasName(out, "new"))

  data <- ictr_toy_inputs(new = 1, new2 = 1)
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 13L)
  expect_true(hasName(out, "new"))
})

test_that("without crucial data errors gracefully", {
  expect_error(ictr_score_inputs(), "missing")
})

test_that("without non-crucial columns throws no error", {
  # TODO ASK: can we drop this columns? They may be needed downstream
  not_crucial <- setdiff(names(ictr_inputs), names(ictr_toy_inputs()))
  data <- select(ictr_inputs, -all_of(not_crucial))
  expect_no_error(ictr_score_inputs(data))
})

test_that("without crucial columns errors gracefully", {
  data <- ictr_toy_inputs(input_co2 = NULL)
  expect_error(ictr_score_inputs(data), "input_co2.*not found")

  data <- ictr_toy_inputs(input_sector = NULL)
  expect_error(ictr_score_inputs(data), "input_sector.*not found")

  data <- ictr_toy_inputs(unit = NULL)
  expect_error(ictr_score_inputs(data), "unit.*not found")
})

test_that("is sensitive to low_threshold with 2 or more input rows but not 1", {
  data <- ictr_toy_inputs(c(1, 1))
  out1 <- ictr_score_inputs(data, low_threshold = .1)
  out2 <- ictr_score_inputs(data, low_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- ictr_toy_inputs()
  out1 <- ictr_score_inputs(data, low_threshold = .1)
  out2 <- ictr_score_inputs(data, low_threshold = .9)
  expect_true(identical(out1, out2))
})

test_that("is sensitive to high_threshold with 2 or more input rows but not 1", {
  data <- ictr_toy_inputs(c(1, 1))
  out1 <- ictr_score_inputs(data, high_threshold = .1)
  out2 <- ictr_score_inputs(data, high_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- ictr_toy_inputs()
  out1 <- ictr_score_inputs(data, high_threshold = .1)
  out2 <- ictr_score_inputs(data, high_threshold = .9)
  expect_true(identical(out1, out2))
})

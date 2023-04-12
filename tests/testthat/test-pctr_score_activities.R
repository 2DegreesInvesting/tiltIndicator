test_that("hasn't change", {
  out <- pctr_ecoinvent_co2 |>
    pctr_score_activities(low_threshold = 0.3, high_threshold = 0.7) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("with minimal data outptus a tibble", {
  data <- pctr_toy_pctr_ecoinvent_co2()
  out <- pctr_score_activities(data)
  expect_s3_class(pctr_score_activities(out), "tbl_df")
})

test_that("with 0-row data returns 0-row tibble", {
  data <- pctr_toy_pctr_ecoinvent_co2()
  out <- pctr_score_activities(data[0, ])
  expect_equal(nrow(out), 0L)
  expect_s3_class(out, "tbl_df")
})

test_that("with n rows outputs n rows", {
  data <- pctr_toy_pctr_ecoinvent_co2()
  out <- pctr_score_activities(data)
  expect_equal(nrow(out), 1L)

  data <- pctr_toy_pctr_ecoinvent_co2(co2_footprint = 1:3)
  out <- pctr_score_activities(data)
  expect_equal(nrow(out), 3L)
})

test_that("outputs 9 columns plus any non crucial column", {
  data <- pctr_toy_pctr_ecoinvent_co2()
  out <- pctr_score_activities(data)
  expect_equal(ncol(out), 9L)

  data <- pctr_toy_pctr_ecoinvent_co2(new = 1)
  out <- pctr_score_activities(data)
  expect_equal(ncol(out), 10L)
  expect_true(hasName(out, "new"))

  data <- pctr_toy_pctr_ecoinvent_co2(new = 1, new2 = 1)
  out <- pctr_score_activities(data)
  expect_equal(ncol(out), 11L)
  expect_true(hasName(out, "new"))
  expect_true(hasName(out, "new2"))
})

test_that("without crucial data errors gracefully", {
  expect_error(pctr_score_activities(), "missing")
})

test_that("without non-crucial columns throws no error", {
  not_crucial <- names(pctr_ecoinvent_co2) |>
    setdiff(names(pctr_toy_pctr_ecoinvent_co2()))
  data <- select(pctr_ecoinvent_co2, -all_of(not_crucial))
  out <- pctr_score_activities(data)
  expect_no_error(out)
})

test_that("without crucial columns errors gracefully", {
  data <- pctr_toy_pctr_ecoinvent_co2(sec = NULL)
  expect_error(pctr_score_activities(data), "sec.*not found")

  data <- pctr_toy_pctr_ecoinvent_co2(unit = NULL)
  expect_error(pctr_score_activities(data), "unit.*not found")

  data <- pctr_toy_pctr_ecoinvent_co2(co2_footprint = NULL)
  expect_error(pctr_score_activities(data), "co2_footprint.*not found")
})

test_that("is sensitive to low_threshold with 2 or more input rows but not 1", {
  data <- pctr_toy_pctr_ecoinvent_co2(c(1, 1))
  out1 <- pctr_score_activities(data, low_threshold = .1)
  out2 <- pctr_score_activities(data, low_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- pctr_toy_pctr_ecoinvent_co2()
  out1 <- pctr_score_activities(data, low_threshold = .1)
  out2 <- pctr_score_activities(data, low_threshold = .9)
  expect_true(identical(out1, out2))
})

test_that("is sensitive to high_threshold with 2 or more input rows but not 1", {
  data <- pctr_toy_pctr_ecoinvent_co2(c(1, 1))
  out1 <- pctr_score_activities(data, high_threshold = .1)
  out2 <- pctr_score_activities(data, high_threshold = .9)
  expect_false(identical(out1, out2))

  # Not sensitive
  data <- pctr_toy_pctr_ecoinvent_co2()
  out1 <- pctr_score_activities(data, high_threshold = .1)
  out2 <- pctr_score_activities(data, high_threshold = .9)
  expect_true(identical(out1, out2))
})

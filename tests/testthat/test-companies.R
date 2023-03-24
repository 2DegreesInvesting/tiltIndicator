test_that("hasn't changed", {
  expect_snapshot(format_robust_snapshot(companies))
})

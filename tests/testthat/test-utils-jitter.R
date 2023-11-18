test_that("jitter_left(x) is always smaller than x", {
  x <- 1
  expect_true(jitter_left(x) < x)
  x <- -1
  expect_true(jitter_left(x) < x)
})

test_that("jitter_right(x) is always smaller than x", {
  x <- 1
  expect_true(jitter_right(x) > x)
  x <- -1
  expect_true(jitter_right(x) > x)
})

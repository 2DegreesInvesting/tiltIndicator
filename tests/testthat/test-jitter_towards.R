test_that("mean jitter towards left is lower than mean x", {
  x <- 1:30

  out <- jitter_towards(x, "left")

  expect_true(mean(out) < mean(x))
})

test_that("mean jitter towards right is greater than mean x", {
  x <- 1:30

  out <- jitter_towards(x, "right")

  expect_true(mean(out) > mean(x))
})

test_that("towards left is sensitive to `amount`", {
  x <- 1:30

  out1 <- jitter_towards(x, "left", amount = 0.1)
  out2 <- jitter_towards(x, "left", amount = 0.9)

  expect_true(mean(out1) > mean(out2))
})

test_that("towards right is sensitive to `amount`", {
  x <- 1:30

  out1 <- jitter_towards(x, "right", amount = 0.1)
  out2 <- jitter_towards(x, "right", amount = 0.9)

  expect_true(mean(out1) < mean(out2))
})

test_that("with non-numeric input errors gracefully", {
  expect_no_error(jitter_towards(1L))
  expect_no_error(jitter_towards(0.1))
  expect_error(jitter_towards("bad"), "must.*numeric")
})

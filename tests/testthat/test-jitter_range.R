test_that("the jitter expands the range", {
  data <- tibble(min = 1:30, max = 1:30)

  out <- jitter_range(data)

  expect_true(mean(out$min_jitter) < mean(data$min))
  expect_true(mean(out$max_jitter) > mean(data$max))
})

test_that("is sensitive to `amount`", {
  data <- tibble(min = 1:30, max = 1:30)

  out1 <- jitter_range(data, amount = 0.1)
  out2 <- jitter_range(data, amount = 0.9)

  expect_true(mean(out2$min_jitter) < mean(out1$min_jitter))
  expect_true(mean(out2$max_jitter) > mean(out1$max_jitter))
})

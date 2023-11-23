test_that("withiout crucial columns errors gracefully", {
  data <- tibble(bad = 1, max = 1)
  expect_error(jitter_range(data), class = "missing_names")

  data <- tibble(min = 1, bad = 1)
  expect_error(jitter_range(data), class = "missing_names")
})

test_that("the jitter expands the range", {
  data <- tibble(min = -100:100, max = -100:100)

  out <- jitter_range(data)

  expect_true(all(out$min_jitter < data$min))
  expect_true(all(out$max_jitter > data$max))
})

test_that("is sensitive to `factor`", {
  data <- tibble(min = 1:30, max = 1:30)

  out1 <- jitter_range(data, factor = 0.1)
  out2 <- jitter_range(data, factor = 0.9)

  expect_true(mean(out2$min_jitter) < mean(out1$min_jitter))
  expect_true(mean(out2$max_jitter) > mean(out1$max_jitter))
})

test_that("is sensitive to `amount`", {
  data <- tibble(min = 1:30, max = 1:30)

  out1 <- jitter_range(data, amount = 0.1)
  out2 <- jitter_range(data, amount = 0.9)

  expect_true(mean(out2$min_jitter) < mean(out1$min_jitter))
  expect_true(mean(out2$max_jitter) > mean(out1$max_jitter))
})

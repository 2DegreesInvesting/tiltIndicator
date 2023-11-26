test_that("if `data` lacks crucial columns, errors gracefully", {
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

test_that("percent noise is even not monotonically decreasing", {
  local_seed(123)
  data <- tibble(min = c(0.1, 1, 10, 100, 1000), max = min)

  out <- jitter_range(data, factor = 1, amount = NULL)

  is_decreasing <- function(x) all(x == cummin(x))
  expect_false(is_decreasing(percent_noise(out$min, out$min_jitter)))
})

test_that("jittering 0 yields non-0", {
  local_seed(123)
  data <- tibble(min = 0, max = min)

  out <- jitter_range(data, factor = 1, amount = NULL)

  expect_true(out$min_jitter != 0)
  expect_true(out$max_jitter != 0)
})

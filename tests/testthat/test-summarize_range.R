test_that("works without groups", {
  data <- tibble(x = 1:3)

  out <- data |>
    summarize_range(x)

  expect_equal(out$min, 1)
  expect_equal(out$max, 3)
})

test_that("works with groups passed via group_by()", {
  data <- tibble(x = 1:4, y = c(1, 1, 2, 2))

  out <- data |>
    group_by(y) |>
    summarize_range(x)

  expect_equal(filter(out, y == 1)$min, 1)
  expect_equal(filter(out, y == 1)$max, 2)
  expect_equal(filter(out, y == 2)$min, 3)
  expect_equal(filter(out, y == 2)$max, 4)
})

test_that("works with groups passed via .by", {
  data <- tibble(x = 1:4, y = c(1, 1, 2, 2))

  out <- data |>
    summarize_range(x, .by = y)

  expect_equal(filter(out, y == 1)$min, 1)
  expect_equal(filter(out, y == 1)$max, 2)
  expect_equal(filter(out, y == 2)$min, 3)
  expect_equal(filter(out, y == 2)$max, 4)
})

test_that("is sensitive to `na.rm`", {
  data <- tibble(x = c(1, 2, 3, NA))

  out1 <- data |> summarize_range(x, na.rm = TRUE)
  expect_equal(out1$min, 1)
  expect_equal(out1$max, 3)

  out2 <- data |> summarize_range(x, na.rm = FALSE)
  expect_equal(out2$min, NA_real_)
  expect_equal(out2$max, NA_real_)
})

test_that("defaults to `na.rm = FALSE`", {
  data <- tibble(x = c(1, NA))

  out <- data |> summarize_range(x)

  expect_equal(out$min, NA_real_)
  expect_equal(out$max, NA_real_)
})

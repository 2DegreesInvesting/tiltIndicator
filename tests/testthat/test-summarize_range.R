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
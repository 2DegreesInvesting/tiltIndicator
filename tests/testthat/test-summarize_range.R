test_that("works without groups", {
  data <- tibble(x = 1:3)

  out <- data |>
    summarize_range("x")

  expect_equal(out$min, 1)
  expect_equal(out$max, 3)
})

test_that("works with groups passed via group_by()", {
  data <- tibble(x = 1:4, y = c(1, 1, 2, 2))

  out <- data |>
    group_by(y) |>
    summarize_range("x")

  expect_equal(filter(out, y == 1)$min, 1)
  expect_equal(filter(out, y == 1)$max, 2)
  expect_equal(filter(out, y == 2)$min, 3)
  expect_equal(filter(out, y == 2)$max, 4)
})

test_that("works with groups passed via .by", {
  data <- tibble(x = 1:4, y = c(1, 1, 2, 2))

  out <- data |>
    summarize_range("x", .by = y)

  expect_equal(filter(out, y == 1)$min, 1)
  expect_equal(filter(out, y == 1)$max, 2)
  expect_equal(filter(out, y == 2)$min, 3)
  expect_equal(filter(out, y == 2)$max, 4)
})

test_that("is sensitive to `na.rm`", {
  data <- tibble(x = c(1, 2, 3, NA))

  out1 <- data |> summarize_range("x", na.rm = TRUE)
  expect_equal(out1$min, 1)
  expect_equal(out1$max, 3)

  out2 <- data |> summarize_range("x", na.rm = FALSE)
  expect_equal(out2$min, NA_real_)
  expect_equal(out2$max, NA_real_)
})

test_that("defaults to `na.rm = FALSE`", {
  data <- tibble(x = c(1, NA))

  out <- data |> summarize_range("x")

  expect_equal(out$min, NA_real_)
  expect_equal(out$max, NA_real_)
})

test_that("works with strings and symbols", {
  data <- tibble(x = 1)
  expect_equal(
    summarize_range(data, x),
    summarize_range(data, "x")
  )

  data <- tibble(x = 1:4, g = letters[c(1, 1, 2, 2)])
  expect_equal(
    summarize_range(data, x, .by = "g"),
    summarize_range(data, "x", .by = "g")
  )

  # For data.frame .by can also be unquoted although it's best avoided
  expect_equal(
    summarize_range(data, x, .by = g),
    summarize_range(data, "x", .by = "g")
  )
})

test_that("with a column name or symbol outputs the same", {
  data <- tibble(x = 1:4, y = c(1, 1, 2, 2))
  expect_equal(
    summarize_range(data, "x", y),
    suppressWarnings(summarize_range(data, x, y))
  )
})

test_that("works with lists", {
  data <- tibble(x = 1:4, y = letters[c(1, 1, 2, 2)], z = y)
  .x <- split(data, data$y)

  out_dfm <- summarize_range(data, "x", "y")
  out_lst <- summarize_range(.x, col = "x", .by = list(a = "y", b = "y"))

  expect_equal(filter(out_dfm, y == "a"), out_lst[["a"]])
  expect_equal(filter(out_dfm, y == "b"), out_lst[["b"]])
})

test_that("with unnamed `.by` errors gracefully", {
  data <- list(a = tibble(x = 1, y = "a"))
  expect_error(summarize_range(data, "x", .by = list("y")), "must.*named")
})

test_that("`.by` can be a vector", {
  data <- list(a = tibble(x = 1, y = "a"))

  expect_equal(
    summarize_range(data, "x", .by = list(a = "y", b = "y")),
    summarize_range(data, "x", .by = c(a = "y", b = "y"))
  )
})

test_that("`.by` can have `NULL` elements", {
  data <- list(a = tibble(x = 1, y = "a"))

  summarize_range(data, "x", .by = list(a = "y", b = NULL))
})

test_that("with unknown class throws a grecefull error", {
  expect_error(summarize_range("bad"), "no.*summarize_range.*character")
})

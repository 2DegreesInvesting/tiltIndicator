test_that("if data lacks crucial columns, errors gracefully", {
  data <- tibble(x = 1, y = 1)
  col <- "x"
  .by <- "y"

  crucial <- col
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by), crucial)

  crucial <- .by
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by), crucial)
})

test_that("adds the new columns `min` and `max`", {
  data <- tibble(x = 1, y = 1)
  col <- "x"
  .by <- "y"

  out <- jitter_range(data, col, .by)

  expect_true(hasName(out, "min"))
  expect_true(hasName(out, "max"))
})

test_that("outputs as many rows as distinct values of .by", {
  data <- tibble(x = 1, y = 1)
  out <- jitter_range(data, "x", .by = "y")
  expect_equal(nrow(out), 1)

  data <- tibble(x = c(1, 1, 1), y = c(1, 1, 2), z = c("a", "b", "c"))
  out <- jitter_range(data, "x", .by = "y")
  expect_equal(nrow(out), 2)

  data <- tibble(x = c(1, 1, 1), y = c(1, 1, 2), z = c("a", "b", "c"))
  out <- jitter_range(data, "x", .by = c("y", "z"))
  expect_equal(nrow(out), 3)
})

test_that("outputs `min_jitter` and `max_jitter`", {
  data <- tibble(x = 1, y = 1)
  col <- "x"
  .by <- "y"

  out <- jitter_range(data, col, .by)

  expect_true(hasName(out, "min_jitter"))
  expect_true(hasName(out, "max_jitter"))
})

test_that("`min_jitter` is lowest and `max_jitter` is highest", {
  data <- tibble(x = 1:10, y = c(rep(1, 5), rep(2, 5)))
  col <- "x"
  .by <- "y"

  out <- jitter_range(data, col, .by)

  expect_true(all(out$min_jitter < out$min))
  expect_true(all(out$max_jitter > out$max))
})

test_that("drops missing values of crucial columns with a warning", {
  data <- tibble(x = c(1, NA), y = 1)
  col <- "x"
  .by <- "y"
  expect_warning(out <- jitter_range(data, col, .by), "NA.*x")
  expect_false(anyNA(out$min_jitter))
  expect_false(anyNA(out$max_jitter))

  data <- tibble(x = 1, y = c(1, NA))
  col <- "x"
  .by <- "y"
  expect_warning(out <- jitter_range(data, col, .by), "NA.*y")
  expect_false(anyNA(out$y))
  expect_false(anyNA(out$min_jitter))
  expect_false(anyNA(out$max_jitter))
})

test_that("is sensitive to `amount`", {
  data <- tibble(x = 1:10, y = 1:10)
  col <- "x"
  .by <- "y"

  out1 <- jitter_range(data, col, .by, amount = 0.1)
  out2 <- jitter_range(data, col, .by, amount = 0.9)

  expect_true(mean(out2$min_jitter) < mean(out1$min_jitter))
  expect_true(mean(out2$max_jitter) > mean(out1$max_jitter))
})

test_that("outputs a named list of one tibble element per output.csv", {
  out <- wrap_rmd(test_path("data", "mtcars.Rmd"))
  expect_type(out, "list")
  expect_named(out, "mtcars")
  expect_equal(out[["mtcars"]], tibble::as_tibble(mtcars))
})

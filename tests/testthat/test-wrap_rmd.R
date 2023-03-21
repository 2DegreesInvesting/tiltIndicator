test_that("outputs a named list of one tibble element per output.csv", {
  rmd <- system.file("extdata", "mtcars.Rmd", package = "tiltIndicator")
  out <- wrap_rmd(rmd)
  expect_type(out, "list")
  expect_named(out, "mtcars")
  expect_equal(out[["mtcars"]], tibble::as_tibble(mtcars))
})

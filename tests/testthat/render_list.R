test_that("outputs a named list of one tibble element per output.csv", {
  path <- system.file("extdata", "mtcars.Rmd", package = "tiltIndicator")
  out <- render_list(path)
  expect_type(out, "list")
  expect_true(any(grepl("data", names(out))))
  expect_equal(out[["data"]], mtcarst)
})

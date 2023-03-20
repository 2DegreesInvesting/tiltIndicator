test_that("returns a path under the parent 'mvp'", {
  out <- mvp_path("product-carbon-transition-risk.Rmd")
  parent <- fs::path_file(fs::path_dir(out))
  expect_equal(parent, "mvp")
})

test_that("mvp_paths() returns a one expected file", {
  expect_true(grepl("product-carbon-transition-risk.Rmd", mvp_paths()))
})

test_that("is sensitive to `pattern`", {
  expect_true(length(mvp_paths(pattern = ".Rmd")) > 0L)
  expect_true(length(mvp_paths(pattern = "bad")) == 0L)
})


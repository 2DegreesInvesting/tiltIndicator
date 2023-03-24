test_that("the parent folder is 'mvp'", {
  parent <- fs::path_file(mvp_path(""))
  expect_equal(parent, "mvp")
})

test_that("is sensitive to `pattern`", {
  expect_true(length(mvp_paths(pattern = ".Rmd")) > 0L)
  expect_true(length(mvp_paths(pattern = "bad")) == 0L)
})

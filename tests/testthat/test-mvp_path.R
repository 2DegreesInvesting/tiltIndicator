test_that("the parent folder is 'mvp'", {
  parent <- fs::path_file(mvp_path(""))
  expect_equal(parent, "mvp")
})

test_that("is sensitive to `pattern`", {
  expect_true(length(mvp_paths(pattern = ".Rmd")) > 0L)
  expect_true(length(mvp_paths(pattern = "bad")) == 0L)
})

test_that("must point to a file that exists or fail gracefully", {
  # Not checking the error message because it's brittle. I get a different one
  # in tests and checks. There must be a way though but didn't research yet.
  expect_error(mvp_path("bad"))
})

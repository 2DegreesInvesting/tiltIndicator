test_that("points to the expected parent directory", {
  out <- tilt_path()
  parent <- fs::path_file(fs::path_dir(out))
  expect_equal(parent, "Downloads")
})

test_that("points to the expected child directory", {
  out <- tilt_path()
  child <- fs::path_file(out)
  expect_equal(child, "tilt")
})

test_that("is sensitive to ...", {
  out <- tilt_path("a", "b")
  parent <- fs::path_file(fs::path_dir(out))
  expect_equal(parent, "a")

  child <- fs::path_file(out)
  expect_equal(child, "b")
})

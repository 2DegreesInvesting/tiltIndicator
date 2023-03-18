test_that("the parent directory is named after the package", {
  out <- data_dir()
  expect_equal(fs::path_file(out), "tiltIndicator")
})

test_that("is sensitive to `version`", {
  out <- data_dir(version = "x.y.z")
  child <- as.character(fs::path_file(out))
  expect_equal(child, "x.y.z")
})

test_that("returns the expected directory structure", {
  expect_true(grepl("Downloads/tilt/tiltIndicator/pctr", pctr_path()))
})

test_that("document_value() outputs the expected text", {
  expect_snapshot(document_value())
})

test_that("warns in a test environment", {
  expect_true(is_testing())
  withr::with_envvar(list("TESTTHAT" = ""), expect_false(is_testing()))
})

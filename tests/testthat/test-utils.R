test_that("document_dataset() outputs the expected text", {
  expect_snapshot(document_dataset())
})

test_that("document_value() outputs the expected text", {
  expect_snapshot(document_value())
})

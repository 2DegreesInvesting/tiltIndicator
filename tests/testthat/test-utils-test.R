test_that("both_increasing() works as expected", {
  expect_true(both_increasing(-1:1, -1:1))
  expect_false(both_increasing(-1:1, 1:-1))
})

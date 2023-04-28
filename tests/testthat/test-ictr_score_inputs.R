test_that("with n rows outputs n rows", {
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  out <- ictr_score_inputs(data)
  expect_equal(nrow(out), 1L)
  data <- tibble(input_co2 = 1:3, input_sector = "a", unit = "u")
  out <- ictr_score_inputs(data)
  expect_equal(nrow(out), 3L)
})

test_that("outputs 11 columns plus any non crucial column", {
  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u")
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 11L)

  data <- tibble(input_co2 = 1, input_sector = "a", unit = "u", new = 1)
  out <- ictr_score_inputs(data)
  expect_equal(ncol(out), 12L)
  expect_true(hasName(out, "new"))
})

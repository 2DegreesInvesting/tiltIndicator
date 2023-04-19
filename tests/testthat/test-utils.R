test_that("stop_if_any_missing_input_co2 throws the expected error", {
  data <- tibble(input_co2 = NA)
  expect_error(stop_if_any_missing_input_co2(data), "input_co2.*missing")
})

test_that("stop_if_any_missing_input_co2 is pipable", {
  data <- tibble(input_co2 = 1)
  expect_equal(stop_if_any_missing_input_co2(data), data)
})

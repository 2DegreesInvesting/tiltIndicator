test_that("stop_if_any_missing_input_co2 throws the expected error", {
  data <- tibble(input_co2 = NA)
  expect_error(stop_if_any_missing_input_co2(data), "input_co2.*missing")
})

test_that("`ictr_inputs` hasn't changed", {
  out <- ictr_inputs |> format_robust_snapshot()
  expect_snapshot(out)
})

test_that("`ictr_companies` hasn't changed", {
  out <- ictr_companies |> format_robust_snapshot()
  expect_snapshot(out)
})

test_that("`input_co2` don't have missing values", {
  expect_no_error(missing_co2(ictr_inputs))
})

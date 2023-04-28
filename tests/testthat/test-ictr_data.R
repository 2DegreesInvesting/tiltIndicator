test_that("`ictr_inputs` hasn't changed", {
  out <- ictr_inputs |> format_robust_snapshot()
  expect_snapshot(out)
})

test_that("`ictr_companies` hasn't changed", {
  out <- ictr_companies |> format_robust_snapshot()
  expect_snapshot(out)
})

test_that("`ictr_inputs$input_co2` has no missing values", {
  expect_false(anyNA(ictr_inputs$input_co2))
})

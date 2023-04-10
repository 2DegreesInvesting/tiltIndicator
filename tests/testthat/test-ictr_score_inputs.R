test_that("hasn't change", {
  out <- ictr_score_inputs(ictr_inputs) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

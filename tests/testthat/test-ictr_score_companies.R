test_that("hasn't change", {
  out <- ictr_inputs |>
    ictr_score_inputs() |>
    ictr_score_companies(ictr_companies) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

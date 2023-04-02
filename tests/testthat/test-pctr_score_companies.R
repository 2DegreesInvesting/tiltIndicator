test_that("hasn't changed", {
  out <- pctr_ecoinvent_co2 |>
    pctr_score_activities(low_threshold = 0.3, high_threshold = 0.7) |>
    pctr_score_companies(pctr_companies) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

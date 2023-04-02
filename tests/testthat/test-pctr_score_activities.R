test_that("hasn't change", {
  out <- pctr_ecoinvent_co2 |>
    pctr_score_activities(low_threshold = 0.3, high_threshold = 0.7) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

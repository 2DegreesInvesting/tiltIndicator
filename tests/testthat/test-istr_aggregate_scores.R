test_that("hasn't changed", {
  data <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    istr_add_reductions(istr_weo_2022) |>
    istr_add_transition_risk()

  out <- format_robust_snapshot(istr_aggregate_scores(data, istr_companies))
  expect_snapshot(out)
})

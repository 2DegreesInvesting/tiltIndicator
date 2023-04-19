test_that("hasn't changed", {
  data <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    istr_add_reductions(istr_weo_2022) |>
    # FIXME: This dataset is surprisingly large
    head()

  out <- format_robust_snapshot(istr_add_transition_risk(data))
  expect_snapshot(out)
})

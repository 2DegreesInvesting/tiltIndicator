test_that("hasn't change", {
  with_transition_risk <- companies |>
    pstr_add_reductions(ep_weo, weo_2022) |>
    pstr_add_transition_risk() |>
    # FIXME: Address warning
    suppressWarnings()

  out <- format_robust_snapshot(with_transition_risk)
  expect_snapshot(out)

})

test_that("hasn't change", {
  with_transition_risk <- pstr_companies |>
    pstr_add_reductions(pstr_ep_weo, pstr_weo_2022) |>
    pstr_add_transition_risk() |>
    # FIXME: Address warning
    suppressWarnings()

  out <- format_robust_snapshot(with_transition_risk)
  expect_snapshot(out)
})

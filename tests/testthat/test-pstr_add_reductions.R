test_that("hasn't changed", {
  with_reductions <- pstr_companies |>
    pstr_add_reductions(pstr_ep_weo, pstr_weo_2022) |>
    # FIXME: Address warning
    suppressWarnings()
  out <- format_robust_snapshot(with_reductions)
  expect_snapshot(out)
})

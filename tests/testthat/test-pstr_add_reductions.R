test_that("hasn't changed", {
  with_reductions <- pstr_add_reductions(companies, ep_weo, weo_2022) |>
    # FIXME: Address warning
    suppressWarnings()
  out <- format_robust_snapshot(with_reductions)
  expect_snapshot(out)
})

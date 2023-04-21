test_that("hasn't changed", {
  out <- istr_mapping(istr_companies, istr_ep_weo) |>
    # FIXME: This dataset is surpisingly large
    head() |>
    format_robust_snapshot() |>
    # FIXME:
    #   Detected an unexpected many-to-many relationship between `x` and `y`.
    # i Row 1 of `x` matches multiple rows in `y`.
    # i Row 1 of `y` matches multiple rows in `x`.
    # i If a many-to-many relationship is expected, set `relationship = "many-to-many"` to silence this warning.
    suppressWarnings()
  expect_snapshot(out)
})

test_that("hasn't changed", {
  out <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    # FIXME: This dataset is surprisingly large
    head() |>
    istr_add_reductions(istr_weo_2022) |>
    # FIXME:
    #   Detected an unexpected many-to-many relationship between `x` and `y`.
    # i Row 1 of `x` matches multiple rows in `y`.
    # i Row 1 of `y` matches multiple rows in `x`.
    # i If a many-to-many relationship is expected, set `relationship = "many-to-many"` to silence this warning.
    suppressWarnings() |>
    format_robust_snapshot()
  expect_snapshot(out)
})

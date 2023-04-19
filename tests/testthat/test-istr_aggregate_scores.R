test_that("hasn't changed", {
  data <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    istr_add_reductions(istr_weo_2022) |>
    istr_add_transition_risk() |>
    # FIXME:
    #   Detected an unexpected many-to-many relationship between `x` and `y`.
    # i Row 1 of `x` matches multiple rows in `y`.
    # i Row 1 of `y` matches multiple rows in `x`.
    # i If a many-to-many relationship is expected, set `relationship = "many-to-many"` to silence this warning.
    suppressWarnings()

  out <- format_robust_snapshot(istr_aggregate_scores(data, istr_companies))
  expect_snapshot(out)
})

test_that("FIXME? Do we intend to return a grouped data frame?", {
  out <- companies |>
    pstr_add_reductions(ep_weo, weo_2022) |>
    pstr_add_transition_risk() |>
    pstr_aggregate_scores() |>
    suppressWarnings()

  expect_true(dplyr::is_grouped_df(out))
})

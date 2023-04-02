test_that("FIXME? Do we intend to return a grouped data frame?", {
  out <- pstr_companies |>
    pstr_add_reductions(pstr_ep_weo, pstr_weo_2022) |>
    pstr_add_transition_risk() |>
    pstr_aggregate_scores(pstr_companies) |>
    suppressWarnings()

  expect_true(dplyr::is_grouped_df(out))
})

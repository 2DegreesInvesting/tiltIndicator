test_that("FIXME? Do we intend to return a grouped data frame?", {
  out <- pstr_companies |>
    pstr_add_reductions(pstr_ep_weo, pstr_weo_2022) |>
    pstr_add_transition_risk() |>
    pstr_aggregate_scores(pstr_companies) |>
    suppressWarnings()

  expect_true(dplyr::is_grouped_df(out))
})

test_that("outputs a result for companies without any products", {
  companies <- pstr_toy_companies('products' = NA)
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  out <- companies |>
    pstr_add_reductions(ep_weo, weo) |>
    pstr_add_transition_risk() |>
    pstr_aggregate_scores(companies)

  expect_equal(FALSE, is.null(out$score_aggregated))
})

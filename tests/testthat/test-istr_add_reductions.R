test_that("hasn't changed", {
  data <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    # FIXME: This dataset is surprisingly large
    head()

  out <- format_robust_snapshot(istr_add_reductions(data, istr_weo_2022))
  expect_snapshot(out)
})

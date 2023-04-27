test_that("outputs the expected columns", {
  weo <- slice(pstr_new_weo_2022, 1)
  ipr <- slice(pstr_new_ipr_2022, 1)
  scenarios <- pstr_prepare_scenario(list(weo = weo, ipr = ipr))
  companies <- pstr_prepare_companies(slice(pstr_new_companies, 1))

  out <- pstr_new(companies, scenarios)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
  expect_equal(names(out)[1:3], c("id", "transition_risk", "score_aggregated"))
})

test_that("the output is not grouped", {
  weo <- slice(pstr_new_weo_2022, 1)
  ipr <- slice(pstr_new_ipr_2022, 1)
  scenarios <- pstr_prepare_scenario(list(weo = weo, ipr = ipr))
  companies <- pstr_prepare_companies(slice(pstr_new_companies, 1))

  out <- pstr_new(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

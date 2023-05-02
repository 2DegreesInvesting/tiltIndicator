test_that("outputs the expected columns", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
  expected <- c("companies_id", "transition_risk", "score_aggregated")
  expect_equal(names(out)[1:3], expected)
})

test_that("outputs the expected columns", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)
  expect_false(dplyr::is_grouped_df(out))
})

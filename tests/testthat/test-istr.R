test_that("outputs common output columns", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expected <- common_output_columns()
  expect_equal(names(out)[1:3], expected)
})

test_that("outputs the expected columns", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)
  expect_false(dplyr::is_grouped_df(out))
})

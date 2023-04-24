test_that("outputs the expected columns", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
})

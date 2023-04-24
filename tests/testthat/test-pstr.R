test_that("outputs the expected columns", {
  companies <- slice(pstr_companies, 1)
  ep_weo <- slice(pstr_ep_weo, 1)
  weo_2022 <- slice(pstr_weo_2022, 1)

  out <- pstr(companies, ep_weo, weo_2022)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
})

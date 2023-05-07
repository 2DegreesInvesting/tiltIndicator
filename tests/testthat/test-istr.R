test_that("outputs expected columns at company level", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})
test_that("outputs common output columns", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expected <- cols_at_company_level()
  expect_equal(names(out)[1:4], expected)
})

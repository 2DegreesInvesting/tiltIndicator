test_that("outputs expected columns at company level", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("with a missing value in the reductions column errors gracefully", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  scenario$reductions <- NA
  ep_weo <- slice(istr_ep_weo, 1)
  expect_error(istr(companies, scenario, ep_weo), "reductions")
})

test_that("works", {
  weo <- slice(pstr_new_weo_2022, 1)
  ipr <- slice(pstr_new_ipr_2022, 1)
  scenarios <- pstr_prepare_scenario(list(weo = weo, ipr = ipr))
  companies <- pstr_prepare_companies(slice(pstr_new_companies, 1))
  companies <- pstr_prepare_companies(pstr_new_companies)
  expect_s3_class(pstr_new_add_reductions(companies, scenarios), "tbl")
})

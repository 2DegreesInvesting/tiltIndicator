test_that("`pstr_new_companies` hasn't changed", {
  companies <- pstr_new_companies
  expect_snapshot(format_robust_snapshot(companies))
})

test_that("`pstr_new_weo_2022` hasn't changed", {
  weo <- pstr_new_weo_2022
  expect_snapshot(format_robust_snapshot(weo))
})

test_that("`pstr_new_ipr_2022` hasn't changed", {
  ipr <- pstr_new_ipr_2022
  expect_snapshot(format_robust_snapshot(ipr))
})

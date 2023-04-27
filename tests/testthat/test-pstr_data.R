test_that("`pstr_new_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_new_companies))
})

test_that("`pstr_new_weo_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_new_weo_2022))
})

test_that("`pstr_new_ipr_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_new_weo_2022))
})

test_that("`pstr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_companies))
})

test_that("`pstr_ep_weo` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_ep_weo))
})

test_that("`pstr_weo_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_weo_2022))
})

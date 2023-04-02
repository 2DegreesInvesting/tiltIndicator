test_that("`companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_companies))
})

test_that("`ep_weo` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_ep_weo))
})

test_that("`weo_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_weo_2022))
})

test_that("`companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(companies))
})

test_that("`ep_weo` hasn't changed", {
  expect_snapshot(format_robust_snapshot(ep_weo))
})

test_that("`weo_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(weo_2022))
})

test_that("`companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::companies))
})

test_that("`inputs` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::inputs))
})

test_that("`products` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::products))
})

test_that("`istr_ep_weo` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::istr_ep_weo))
})

test_that("`istr_weo_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::istr_weo_2022))
})

test_that("`istr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::istr_companies))
})

test_that("`pstr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::pstr_companies))
})

test_that("`pstr_scenarios` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::pstr_scenarios))
})

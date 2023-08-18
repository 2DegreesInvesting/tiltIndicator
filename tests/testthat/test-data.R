test_that("`xstr_scenarios` hasn't changed", {
  expect_snapshot(format_robust_snapshot(tiltIndicator::xstr_scenarios))
})

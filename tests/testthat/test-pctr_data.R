test_that("`pctr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pctr_companies))
})

test_that("`pctr_ecoinvent_co2` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pctr_ecoinvent_co2))
})

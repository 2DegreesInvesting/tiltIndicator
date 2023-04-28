test_that("`pstr_companies` hasn't changed", {
  companies <- pstr_companies
  expect_snapshot(format_robust_snapshot(companies))
})

test_that("`pstr_scenarios` hasn't changed", {
  scenarios <- pstr_scenarios
  expect_snapshot(format_robust_snapshot(scenarios))
})

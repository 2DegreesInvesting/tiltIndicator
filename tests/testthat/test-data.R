test_that("`ictr_inputs` hasn't changed", {
  out <- ictr_inputs |> format_robust_snapshot()
  expect_snapshot(out)
})

test_that("`ictr_companies` hasn't changed", {
  out <- ictr_companies |> format_robust_snapshot()
  expect_snapshot(out)
})

test_that("`pctr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pctr_companies))
})

test_that("`istr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(istr_companies))
})

test_that("`istr_ep_weo` hasn't changed", {
  expect_snapshot(format_robust_snapshot(istr_ep_weo))
})

test_that("`istr_weo_2022` hasn't changed", {
  expect_snapshot(format_robust_snapshot(istr_weo_2022))
})

test_that("`pctr_ecoinvent_co2` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pctr_ecoinvent_co2))
})

test_that("`pstr_companies` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_companies))
})

test_that("`pstr_scenarios` hasn't changed", {
  expect_snapshot(format_robust_snapshot(pstr_scenarios))
})

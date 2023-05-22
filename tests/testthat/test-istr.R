test_that("outputs expected columns at company level", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  ep_weo <- slice(istr_ep_weo, 1)

  out <- istr(companies, scenario, ep_weo)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("with a missing value in the reductions column errors gracefully", {
  companies <- slice(istr_companies, 1)
  scenario <- slice(istr_weo_2022, 1)
  scenario$reductions <- NA
  ep_weo <- slice(istr_ep_weo, 1)
  expect_error(istr(companies, scenario, ep_weo), "reductions")
})

test_that("a 0-row `companies` yields an error", {
  expect_error(
    istr(istr_companies[0L, ], istr_weo_2022, istr_ep_weo),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `scenarios` yields an error", {
  expect_error(
    istr(istr_companies, istr_weo_2022[0L, ], istr_ep_weo),
    "scenarios.*can't have 0-row"
  )
})

test_that("the thresholds are in the range 0 to 1", {
  istr_arguments <- formals(istr_at_product_level)

  low_threshold <- eval(istr_arguments$low_threshold)
  high_threshold <- eval(istr_arguments$high_threshold)

  expect_true(low_threshold >= 0 & low_threshold <= 1)
  expect_true(high_threshold >= 0 & high_threshold <= 1)
})

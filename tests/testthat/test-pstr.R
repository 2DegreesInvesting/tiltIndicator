test_that("hasn't changed", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs common output columns", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)

  out <- pstr(companies, scenarios)

  expected <- common_output_columns()
  expect_equal(names(out)[1:4], expected)
})

test_that("the output is not grouped", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("with a 0-row `companies` outputs a well structured 0-row tibble", {
  out0 <- pstr(pstr_companies[0L, ], pstr_scenarios)
  expect_s3_class(out0, "tbl")
  expect_equal(nrow(out0), 0L)

  out1 <- pstr(pstr_companies[1L, ], pstr_scenarios)
  expect_s3_class(out1, "tbl")

  expect_equal(names(out0), names(out1))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(pstr(bad, scenarios), crucial)

  crucial <- "company_name"
  bad <- select(companies, -all_of(crucial))
  expect_error(pstr(bad, scenarios), crucial)

  crucial <- "type"
  bad <- select(companies, -all_of(crucial))
  expect_error(pstr(bad, scenarios), crucial)

  crucial <- "sector"
  bad <- select(companies, -all_of(crucial))
  expect_error(pstr(bad, scenarios), crucial)

  crucial <- "subsector"
  bad <- select(companies, -all_of(crucial))
  expect_error(pstr(bad, scenarios), crucial)
})

test_that("if `scenarios` lacks crucial columns, errors gracefully", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)

  crucial <- "type"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(pstr(companies, bad), crucial)

  crucial <- "sector"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(pstr(companies, bad), crucial)

  crucial <- "subsector"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(pstr(companies, bad), crucial)

  crucial <- "year"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(pstr(companies, bad), crucial)

  crucial <- "scenario"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(pstr(companies, bad), crucial)
})

test_that("outputs correct values for edge cases", {
  companies <- tibble(
    company_id = "cta-commodity-trading-austria-gmbh_00000005215384-001",
    company_name = "cta - commodity trading austria gmbh",
    type = "ipr",
    sector = "total",
    subsector = "energy",
  )
  scenarios <- tibble(
    scenario = "1.5c required policy scenario",
    sector = "total",
    subsector = "energy",
    year = 2020,
    value = 99,
    reductions = 0,
    type = "ipr",
  )

  out <- pstr(companies, mutate(scenarios, reductions = NA))
  expect_equal("no_sector", out$risk_category)

  out <- pstr(companies, mutate(scenarios, reductions = 30))
  expect_equal("low", out$risk_category)

  out <- pstr(companies, mutate(scenarios, reductions = 30.1))
  expect_equal("medium", out$risk_category)

  out <- pstr(companies, mutate(scenarios, reductions = 70))
  expect_equal("medium", out$risk_category)

  out <- pstr(companies, mutate(scenarios, reductions = 70.1))
  expect_equal("high", out$risk_category)

  out <- pstr(companies, mutate(scenarios, reductions = -1))
  expect_equal("low", out$risk_category)
})

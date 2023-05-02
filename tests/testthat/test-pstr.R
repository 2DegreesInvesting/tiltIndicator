test_that("snapshot", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs the expected columns", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
  expect_equal(names(out)[1:3], c("id", "transition_risk", "score_aggregated"))
})

test_that("the output is not grouped", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("if a company has no products, shares are NA (#176)", {
  skip("FIXE: Bug #176?")
  companies <- mutate(slice(pstr_companies, 1), products = NA)
  scenarios <- pstr_scenarios
  out <- pstr(companies, scenarios)
  expect_equal(unique(out$score_aggregated), NA)
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

test_that("with a missing value in `scenarios$reductions` errors gracefully", {
  skip("TODO : Ask Tilman if this should throw an error.")
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)
  scenarios$reductions <- NA
  expect_error(pstr(companies, scenarios))
})

test_that("outputs correct values for edge cases", {

  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)
  #TODO : create updated toy data set for scenarios and companies
  scenarios$type <- "ipr"
  scenarios$sector <- "total"
  scenarios$subsector <- "energy"

  edge <- NA
  scenarios$reductions <- edge
  out <- pstr(companies, scenarios)
  expect_equal("no_sector", out$transition_risk)

  edge <- 30
  scenarios$reductions <- edge
  out <- pstr(companies, scenarios)
  expect_equal("low", out$transition_risk)

  edge <- 30.1
  scenarios$reductions <- edge
  out <- pstr(companies, scenarios)
  expect_equal("medium", out$transition_risk)

  edge <- 70
  scenarios$reductions <- edge
  out <- pstr(companies, scenarios)
  expect_equal("medium", out$transition_risk)

  edge <- 70.1
  scenarios$reductions <- edge
  out <- pstr(companies, scenarios)
  expect_equal("high", out$transition_risk)

  edge <- -10
  scenarios$reductions <- edge
  out <- pstr(companies, scenarios)
  expect_equal("low", out$transition_risk)

})

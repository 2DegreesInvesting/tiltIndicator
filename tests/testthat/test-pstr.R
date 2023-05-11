test_that("hasn't changed", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs expected columns at company level", {
  companies <- slice(pstr_companies, 1)
  scenarios <- pstr_scenarios
  out <- pstr(companies, scenarios)
  expect_named(out, cols_at_company_level())
})

test_that("the output is not grouped", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("with a 0-row `companies` outputs a well structured 0-row tibble", {
  companies <- pstr_companies[0L, ]
  out <- pstr(companies, pstr_scenarios)
  expect_equal(out, ptype_at_company_level())
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)

  crucial <- "company_id"
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

test_that("thresholds yield expected low, medium, and high risk categories", {
  companies <- tibble(
    company_id = "cta-commodity-trading-austria-gmbh_00000005215384-001",
    type = "ipr",
    sector = "total",
    subsector = "energy",
    clustered = "any",
    activity_uuid_product_uuid = "any",
    tilt_sector = "any",
    tilt_subsector = "any",
  )
  scenarios <- tibble(
    scenario = "1.5c required policy scenario",
    sector = "total",
    subsector = "energy",
    year = 2020,
    # value = 99,
    reductions = 0,
    type = "ipr",
  )

  default_low_mid <- formals(pstr)$low_threshold
  out <- pstr(companies, mutate(scenarios, reductions = default_low_mid))
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_low_mid <- formals(pstr)$low_threshold + 0.001
  out <- pstr(companies, mutate(scenarios, reductions = above_default_low_mid))
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  default_mid_high <- formals(pstr)$high_threshold
  out <- pstr(companies, mutate(scenarios, reductions = default_mid_high))
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_mid_high <- formals(pstr)$high_threshold + 0.001
  out <- pstr(companies, mutate(scenarios, reductions = above_default_mid_high))
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(1, filter(out, risk_category == "high")$value)

  below_0 <- -0.001
  out <- pstr(companies, mutate(scenarios, reductions = below_0))
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)
})

test_that("outputs values in proportion", {
  companies <- slice(pstr_companies, 1)
  scenarios <- pstr_scenarios
  out <- pstr(companies, scenarios)
  expect_true(all(out$value <= 1.0))
})

test_that("each company has risk categories low, medium, and high (#215)", {
  companies <- slice(pstr_companies, 1)
  scenarios <- pstr_scenarios
  out <- pstr(companies, scenarios)
  risk_categories <- sort(unique(out$risk_category))
  expect_equal(risk_categories, c("high", "low", "medium"))
})

test_that("with a missing value in the reductions column errors gracefully", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(pstr_scenarios, 1)
  scenarios$reductions <- NA
  expect_error(pstr(companies, scenarios), "reductions")
})

test_that("grouped_by includes the type of scenario", {
  companies <- slice(pstr_companies, 1)
  ipr <- filter(pstr_scenarios, type == "ipr")
  out <- pstr(companies, ipr)
  expect_true(all(grepl("ipr", unique(out$grouped_by))))

  weo <- filter(pstr_scenarios, type == "weo")
  out <- pstr(companies, weo)
  expect_true(all(grepl("ipr", unique(out$grouped_by))))
})

test_that("with type ipr, for each company and grouped_by value sums 1 (#216)", {
  .type <- "ipr"
  companies <- pstr_companies |>
    filter(type == .type) |>
    filter(company_id %in% first(company_id))
  scenarios <- pstr_scenarios |>
    filter(type == .type)

  out <- pstr(companies, scenarios)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
})

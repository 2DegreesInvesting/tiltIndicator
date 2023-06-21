test_that("hasn't changed", {
  scenarios <- xstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs expected columns at company level", {
  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios
  out <- pstr(companies, scenarios)
  expect_named(out, cols_at_company_level())
})

test_that("the output is not grouped", {
  scenarios <- xstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)

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
  scenarios <- slice(xstr_scenarios, 1)

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
    company_id = "a",
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
    reductions = 0,
    type = "ipr",
  )

  default_low_mid <- 1 / 3
  out <- pstr(companies, mutate(scenarios, reductions = default_low_mid))
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_low_mid <- 1 / 3 + 0.001
  out <- pstr(companies, mutate(scenarios, reductions = above_default_low_mid))
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  default_mid_high <- 2 / 3
  out <- pstr(companies, mutate(scenarios, reductions = default_mid_high))
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_mid_high <- 2 / 3 + 0.001
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
  scenarios <- xstr_scenarios
  out <- pstr(companies, scenarios)
  expect_true(all(out$value <= 1.0))
})

test_that("each company has risk categories low, medium, and high (#215)", {
  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios
  out <- pstr(companies, scenarios)
  risk_categories <- sort(unique(out$risk_category))
  expect_equal(risk_categories, c("high", "low", "medium"))
})

test_that("grouped_by includes the type of scenario", {
  .type <- "ipr"
  companies <- filter(slice(pstr_companies, 1), type == .type)
  co2 <- filter(xstr_scenarios, type == .type)

  out <- pstr(companies, co2)

  expect_true(all(grepl(.type, unique(out$grouped_by))))
})

test_that("with type ipr, for each company and grouped_by value sums 1 (#216)", {
  .type <- "ipr"
  companies <- pstr_companies |>
    filter(type == .type) |>
    filter(company_id %in% first(company_id))
  scenarios <- xstr_scenarios |>
    filter(type == .type)

  out <- pstr(companies, scenarios)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
})

test_that("values sum 1 or are NA if a company does or doesn't match (#176)", {
  companies <- tibble(
    company_id = c("a", "b"),
    type = c("x", "y"),
    sector = c("x", "y"),
    subsector = c("x", "y"),
    clustered = "x",
    activity_uuid_product_uuid = "x",
    tilt_sector = "x",
    tilt_subsector = "x",
  )

  scenarios <- tibble(
    type = "x",
    sector = "x",
    subsector = "x",
    scenario = "x",
    year = 2030,
    reductions = 1,
  )

  out <- pstr(companies, scenarios)
  expect_equal(unique(out$companies_id), c("a", "b"))

  with_match <- filter(out, companies_id == "a")
  sum <- unique(summarise(with_match, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)

  without_match <- filter(out, companies_id == "b")
  all_na <- all(is.na(without_match$value))
  expect_true(all_na)
})

test_that("no matches yield the expected prototype (#176)", {
  companies <- tibble(
    company_id = c("a", "b"),
    type = c("x", "y"),
    sector = c("x", "y"),
    subsector = c("x", "y"),
    clustered = "x",
    activity_uuid_product_uuid = "x",
    tilt_sector = "x",
    tilt_subsector = "x",
  )

  scenarios <- tibble(
    type = "x",
    sector = "x",
    subsector = "x",
    scenario = "x",
    year = 2030,
    reductions = 1,
  )

  out <- pstr(companies, scenarios)
  unmatched <- filter(out, companies_id == "b")
  expect_equal(unique(unmatched$companies_id), c("b"))
  expect_equal(unique(unmatched$grouped_by), c("y_NA_NA"))
  expect_equal(unique(unmatched$risk_category), c("high", "medium", "low"))
  expect_equal(unique(unmatched$value), NA_real_)
})

test_that("with type weo, for each company and grouped_by value sums 1 (#308)", {
  .type <- "weo"
  companies <- pstr_companies |>
    filter(type == .type) |>
    filter(company_id %in% first(company_id))
  scenarios <- xstr_scenarios |>
    filter(type == .type)

  out <- pstr(companies, scenarios)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
})

test_that("error if a `type` has all `NA` in `sector` & `subsector` (#310)", {
  companies <- tibble(
    company_id = "a",
    type = "b",
    sector = "c",
    subsector = "d",
    clustered = "e",
    activity_uuid_product_uuid = "f",
    tilt_sector = "g",
    tilt_subsector = "i",
  )
  # For type "b" all `sector` and `subsector` are `NA`
  scenarios <- tibble(
    type = c("b", "b", "x", "x"),
    scenario = c("y", "y", "z", "z"),
    sector = c(NA_character_, NA_character_, "c", "c"),
    subsector = c(NA_character_, NA_character_, "d", "d"),
    year = 2030,
    reductions = 1,
  )
  expect_error(pstr(companies, scenarios), "sector.*subsector.*type")
})

test_that("a 0-row `companies` yields an error", {
  expect_error(
    pstr(pstr_companies[0L, ], xstr_scenarios),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `scenarios` yields an error", {
  expect_error(
    pstr(slice(pstr_companies, 1), xstr_scenarios[0L, ]),
    "scenario.*can't have 0-row"
  )
})

test_that("NA in reductions yields expected risk_category and NAs in value (#300)", {
  companies <- tibble(
    company_id = "1",
    type = "a",
    sector = "b",
    subsector = "c",
    clustered = "any",
    activity_uuid_product_uuid = "x",
    tilt_sector = "x",
    tilt_subsector = "x",
  )
  scenarios <- tibble(
    scenario = "2",
    sector = "b",
    subsector = "c",
    year = 2020,
    reductions = NA,
    type = "a",
  )

  out <- pstr(companies, scenarios)
  expect_true(all(is.na(out$value)))
})

test_that("NA in `risk_category` are dropped except to preserve companies (#)", {
  skip("TODO")

  # Debug xstr_polish_output_at_company_level() and
  # see how if it gets NAs in risk_category. Else rewreite
  # the issue title.

  companies <- tibble(
    company_id = "a",
    type = "a",
    sector = "a",
    subsector = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a",
    tilt_sector = "a",
    tilt_subsector = "a",
  )
  scenarios <- tibble(
    scenario = "a",
    sector = NA,
    subsector = "b",
    year = 2020,
    reductions = NA,
    type = "b",
  )

  pstr(companies, scenarios)
  out <- pstr(companies, scenarios)
  expect_true(all(is.na(out$value)))
})

test_that("1 company w/ 2 matching products yields 3 values that sum 1 (#393)", {
  # TODO: Find and remove redundant test
  companies <- tibble(
    company_id = "a",
    type = "a",
    sector = c("a", "b"),
    subsector = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a",
    tilt_sector = "a",
    tilt_subsector = "a",
  )

  scenarios <- tibble(
    type = "a",
    sector = c("a", "b"),
    subsector = "a",
    scenario = "a",
    year = 2025,
    reductions = 1,
  )

  out <- pstr(companies, scenarios)
  expect_equal(nrow(out), 3L)
  expect_equal(sum(out$value), 1L)
  expect_false(anyNA(out$value))
})

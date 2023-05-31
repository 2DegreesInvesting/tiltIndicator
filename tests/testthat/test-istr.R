test_that("hasn't changed", {
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs

  out <- istr(companies, scenarios, inputs)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs expected columns at company level", {
  companies <- slice(istr_companies, 1)
  scenarios <- slice(istr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)

  out <- istr(companies, scenarios, inputs)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("the output is not grouped", {
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs

  out <- istr(companies, scenarios, inputs)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(istr(bad, scenarios, inputs), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(istr(bad, scenarios, inputs), crucial)
})

# TODO: Common test in both istr and pstr because both use same scenario dataset
test_that("if `scenarios` lacks crucial columns, errors gracefully", {
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs

  crucial <- "type"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(istr(companies, bad, inputs), crucial)

  crucial <- "sector"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(istr(companies, bad, inputs), crucial)

  crucial <- "subsector"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(istr(companies, bad, inputs), crucial)

  crucial <- "year"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(istr(companies, bad, inputs), crucial)

  crucial <- "scenario"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(istr(companies, bad, inputs), crucial)
})

test_that("if `inputs` lacks crucial columns, errors gracefully", {
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs

  crucial <- "type"
  bad <- select(inputs, -all_of(crucial))
  expect_error(istr(companies, scenarios, bad), crucial)

  crucial <- "sector"
  bad <- select(inputs, -all_of(crucial))
  expect_error(istr(companies, scenarios, bad), crucial)

  crucial <- "subsector"
  bad <- select(inputs, -all_of(crucial))
  expect_error(istr(companies, scenarios, bad), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(inputs, -all_of(crucial))
  expect_error(istr(companies, scenarios, bad), crucial)
})

test_that("thresholds yield expected low, medium, and high risk categories", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "any",
    clustered = "any",
    activity_uuid_product_uuid = "any",
    ei_activity_name = "any",
    unit = "unit"
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "any",
    input_activity_uuid_product_uuid = "any",
    input_tilt_sector = "any",
    input_tilt_subsector = "any",
    type = "ipr",
    sector = "total",
    subsector = "energy",
    input_unit = "any",
    input_isic_4digit = "4578",
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

  default_low_mid <- 1 / 3
  out <- istr(companies, mutate(scenarios, reductions = default_low_mid), inputs)
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_low_mid <- 1 / 3 + 0.001
  out <- istr(companies, mutate(scenarios, reductions = above_default_low_mid), inputs)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  default_mid_high <- 2 / 3
  out <- istr(companies, mutate(scenarios, reductions = default_mid_high), inputs)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_mid_high <- 2 / 3 + 0.001
  out <- istr(companies, mutate(scenarios, reductions = above_default_mid_high), inputs)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(1, filter(out, risk_category == "high")$value)

  below_0 <- -0.001
  out <- istr(companies, mutate(scenarios, reductions = below_0), inputs)
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)
})

# TODO: This test should be changed to handle `NA` values in the `value` column
test_that("outputs values in proportion", {
  companies <- istr_companies |> slice(3)
  scenarios <- istr_scenarios
  inputs <- istr_inputs
  out <- istr(companies, scenarios, inputs)
  expect_true(all(out$value <= 1.0))
})

test_that("each company has risk categories low, medium, and high (#215)", {
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios
  inputs <- istr_inputs
  out <- istr(companies, scenarios, inputs)
  risk_categories <- sort(unique(out$risk_category))
  expect_equal(risk_categories, c("high", "low", "medium"))
})

test_that("grouped_by includes the type of scenario", {
  .type <- "ipr"
  companies <- istr_companies |> slice(1)
  scenarios <- istr_scenarios |> filter(type == .type)
  inputs <- istr_inputs |> filter(type == .type)

  out <- istr(companies, scenarios, inputs)
  expect_true(all(grepl(.type, unique(out$grouped_by))))
})

# TODO: This test should be changed to handle `NA` values in the `value` column
test_that("with type ipr, for each company and grouped_by value sums 1 (#216)", {
  .type <- "ipr"
  companies <- istr_companies |> slice(3)
  scenarios <- istr_scenarios |> filter(type == .type)
  inputs <- istr_inputs |> filter(type == .type)

  out <- istr(companies, scenarios, inputs)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
})

test_that("values sum 1 or are NA if a company does or doesn't match (#176)", {
  scenarios <- tibble(
    scenario = "x",
    sector = "x",
    subsector = "x",
    year = 2020,
    reductions = 1,
    type = "x",
  )

  companies <- tibble(
    company_id = c("a", "b"),
    tilt_sector = c("any", "any"),
    clustered = "x",
    activity_uuid_product_uuid = c("x", "y"),
    ei_activity_name = "x",
    unit = "x"
  )

  inputs <- tibble(
    activity_uuid_product_uuid = c("x", "y"),
    input_activity_uuid_product_uuid = c("any", "any"),
    input_tilt_sector = c("any", "any"),
    input_tilt_subsector = c("any", "any"),
    type = c("x", "y"),
    sector = c("x", "y"),
    subsector = c("x", "y"),
    input_unit = "any",
    input_isic_4digit = "4578",
  )

  out <- istr(companies, scenarios, inputs)
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
    tilt_sector = c("any", "any"),
    clustered = "x",
    activity_uuid_product_uuid = c("x", "y"),
    ei_activity_name = "x",
    unit = "x"
  )

  inputs <- tibble(
    activity_uuid_product_uuid = c("x", "y"),
    input_activity_uuid_product_uuid = c("any", "any"),
    input_tilt_sector = c("any", "any"),
    input_tilt_subsector = c("any", "any"),
    type = c("x", "y"),
    sector = c("x", "y"),
    subsector = c("x", "y"),
    input_unit = "any",
    input_isic_4digit = "4578",
  )

  scenarios <- tibble(
    type = "x",
    sector = "x",
    subsector = "x",
    scenario = "x",
    year = 2030,
    reductions = 1,
  )

  out <- istr(companies, scenarios, inputs)
  unmatched <- filter(out, companies_id == "b")
  expect_equal(unique(unmatched$companies_id), c("b"))
  expect_equal(unique(unmatched$grouped_by), c("y_NA_NA"))
  expect_equal(unique(unmatched$risk_category), c("high", "medium", "low"))
  expect_equal(unique(unmatched$value), NA_real_)
})

# TODO: This test should be changed to handle `NA` values in the `value` column
test_that("with type weo, for each company and grouped_by value sums 1 (#308)", {
  .type <- "weo"
  companies <- istr_companies |> slice(3)
  scenarios <- istr_scenarios |> filter(type == .type)
  inputs <- istr_inputs |> filter(type == .type)

  out <- istr(companies, scenarios, inputs)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
})

test_that("error if a `type` has all `NA` in `sector` & `subsector` (#310)", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "any",
    clustered = "x",
    activity_uuid_product_uuid = "f",
    ei_activity_name = "x",
    unit = "x"
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "f",
    input_activity_uuid_product_uuid = "any",
    input_tilt_sector = "any",
    input_tilt_subsector = "any",
    type = "b",
    sector = "c",
    subsector = "d",
    input_unit = "any",
    input_isic_4digit = "4578",
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
  expect_error(istr(companies, scenarios, inputs), "sector.*subsector.*type")
})

test_that("a 0-row `companies` yields an error", {
  expect_error(
    istr(istr_companies[0L, ], istr_scenarios, istr_inputs),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `scenarios` yields an error", {
  expect_error(
    istr(istr_companies, istr_scenarios[0L, ], istr_inputs),
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

test_that("NA in the reductions column yields `NA` in risk_category at product level", {
  scenarios <- tibble(
    reductions = NA,
    scenario = "2",
    sector = "b",
    subsector = "c",
    year = 2020,
    type = "a",
  )

  companies <- tibble(
    company_id = "1",
    ei_activity_name = "x",
    unit = "x",
    clustered = "any",
    activity_uuid_product_uuid = "x",
    tilt_sector = "x",
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "x",
    input_activity_uuid_product_uuid = "any",
    input_tilt_sector = "any",
    input_tilt_subsector = "any",
    input_unit = "y",
    input_isic_4digit = "y",
    type = "a",
    sector = "b",
    subsector = "c"
  )

  out <- istr_at_product_level(companies, scenarios, inputs)
  expect_equal(out$risk_category, NA_character_)
})

test_that("NA in the reductions column should be ignored from the value calculations", {
  companies <- tibble(
    company_id = "1",
    ei_activity_name = "x",
    unit = "x",
    clustered = "any",
    activity_uuid_product_uuid = "x",
    tilt_sector = "x",
  )
  scenarios <- tibble(
    scenario = "2",
    sector = "b",
    subsector = "c",
    year = 2020,
    reductions = NA,
    type = "a",
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "x",
    input_activity_uuid_product_uuid = "any",
    input_tilt_sector = "any",
    input_tilt_subsector = "any",
    input_unit = "y",
    input_isic_4digit = "y",
    type = "a",
    sector = "b",
    subsector = "c"
  )

  out <- istr(companies, scenarios, inputs)
  expect_true(all(is.na(out$value)))
})

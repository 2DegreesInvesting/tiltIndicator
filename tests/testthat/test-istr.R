test_that("hasn't changed", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs expected columns at company level", {
  companies <- slice(istr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("the output is not grouped", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("thresholds yield expected low, medium, and high risk categories", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "any",
    clustered = "any",
    activity_uuid_product_uuid = "any"
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

test_that("outputs values in proportion", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs
  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  expect_true(all(na.omit(out$value) <= 1.0))
})

test_that("each company has risk categories low, medium, and high (#215)", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs
  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  risk_categories <- sort(unique(out$risk_category))
  expect_equal(risk_categories, c("high", "low", "medium"))
})

test_that("grouped_by includes the type of scenario", {
  .type <- "ipr"
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios |> filter(type == .type)
  inputs <- istr_inputs |> filter(type == .type)

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  expect_true(all(grepl(.type, unique(out$grouped_by))))
})

test_that("with type ipr, for each company and grouped_by value sums 1 (#216)", {
  .type <- "ipr"
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios |> filter(type == .type)
  inputs <- istr_inputs |> filter(type == .type)

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(na.omit(sum$value_sum) |> near(1)))
})

test_that("with type weo, for each company and grouped_by value sums 1 (#308)", {
  .type <- "weo"
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios |> filter(type == .type)
  inputs <- istr_inputs |> filter(type == .type)

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(na.omit(sum$value_sum) |> near(1)))
})

test_that("error if a `type` has all `NA` in `sector` & `subsector` (#310)", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "any",
    clustered = "x",
    activity_uuid_product_uuid = "f"
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
    istr(istr_companies[0L, ], xstr_scenarios, istr_inputs),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `scenarios` yields an error", {
  expect_error(
    istr(istr_companies, xstr_scenarios[0L, ], istr_inputs),
    "scenarios.*can't have 0-row"
  )
})

test_that("NA in reductions yields expected risk_category and NAs in value (#300)", {
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

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  expect_true(all(is.na(out$value)))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(istr_companies, 1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  out1 <- istr(companies, scenarios, inputs, low_threshold = .1)
  out2 <- istr(companies, scenarios, inputs, low_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("values sum 1", {
  scenarios <- tibble(
    scenario = "a",
    sector = "a",
    subsector = "a",
    year = 2050,
    reductions = 1,
    type = "a",
  )

  companies <- tibble(
    company_id = "a",
    tilt_sector = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a"
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "a",
    input_activity_uuid_product_uuid = "a",
    input_tilt_sector = "a",
    input_tilt_subsector = "a",
    type = "a",
    sector = "a",
    subsector = "a",
    input_unit = "a",
    input_isic_4digit = "a",
  )

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)
  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a"
  )

  scenarios <- tibble(
    type = "a",
    sector = "a",
    subsector = "a",
    scenario = "a",
    year = 2030,
    reductions = 1,
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "a",
    input_activity_uuid_product_uuid = "a",
    input_tilt_sector = "a",
    input_tilt_subsector = "a",
    type = "a",
    sector = "a",
    subsector = c("a", "unmatched"),
    input_unit = "a",
    input_isic_4digit = "a",
  )

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)

  expect_equal(nrow(out), 3L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 3L)
  expect_false(anyNA(out))
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a"
  )

  scenarios <- tibble(
    type = "a",
    sector = "unmatched",
    subsector = "a",
    scenario = "a",
    year = 2030,
    reductions = 1,
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "a",
    input_activity_uuid_product_uuid = "a",
    input_tilt_sector = "a",
    input_tilt_subsector = "a",
    type = "a",
    sector = "a",
    subsector = "a",
    input_unit = "a",
    input_isic_4digit = "a",
  )

  product <- istr_at_product_level(companies, scenarios, inputs)
  out <- istr_at_company_level(product)

  expect_equal(nrow(out), 1)
  expect_equal(out$companies_id, "a")
  expect_true(is.na(out$value))
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$grouped_by))
})

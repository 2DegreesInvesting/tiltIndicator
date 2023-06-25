test_that("still works but warns deprecation", {
  companies <- pstr_companies |> slice(1)
  scenarios <- xstr_scenarios

  expect_snapshot({
    product <- pstr_at_product_level(companies, scenarios)
    out <- pstr_at_company_level(product)
    expect_named(out, cols_at_company_level())
  })
})

test_that("hasn't changed", {
  

  scenarios <- xstr_scenarios
  companies <- pstr_companies |> slice(1)
  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs expected columns at company level", {
  

  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios
  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  expect_named(out, cols_at_company_level())
})

test_that("the output is not grouped", {
  

  scenarios <- xstr_scenarios
  companies <- pstr_companies |> slice(1)
  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  expect_false(dplyr::is_grouped_df(out))
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
  product <- pstr_at_product_level(companies, mutate(scenarios, reductions = default_low_mid))
  out <- pstr_at_company_level(product)
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_low_mid <- 1 / 3 + 0.001
  product <- pstr_at_product_level(companies, mutate(scenarios, reductions = above_default_low_mid))
  out <- pstr_at_company_level(product)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  default_mid_high <- 2 / 3
  product <- pstr_at_product_level(companies, mutate(scenarios, reductions = default_mid_high))
  out <- pstr_at_company_level(product)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_mid_high <- 2 / 3 + 0.001
  product <- pstr_at_product_level(companies, mutate(scenarios, reductions = above_default_mid_high))
  out <- pstr_at_company_level(product)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(1, filter(out, risk_category == "high")$value)

  below_0 <- -0.001
  product <- pstr_at_product_level(companies, mutate(scenarios, reductions = below_0))
  out <- pstr_at_company_level(product)
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)
})

test_that("outputs values in proportion", {
  

  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios
  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  expect_true(all(out$value <= 1.0))
})

test_that("each company has risk categories low, medium, and high (#215)", {
  

  companies <- slice(pstr_companies, 1)
  scenarios <- xstr_scenarios
  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  risk_categories <- sort(unique(out$risk_category))
  expect_equal(risk_categories, c("high", "low", "medium"))
})

test_that("with type ipr, for each company and grouped_by value sums 1 (#216)", {
  

  .type <- "ipr"
  companies <- pstr_companies |>
    filter(type == .type) |>
    filter(company_id %in% first(company_id))
  scenarios <- xstr_scenarios |>
    filter(type == .type)

  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
})

test_that("with type weo, for each company and grouped_by value sums 1 (#308)", {
  

  .type <- "weo"
  companies <- pstr_companies |>
    filter(type == .type) |>
    filter(company_id %in% first(company_id))
  scenarios <- xstr_scenarios |>
    filter(type == .type)

  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  sum <- out |>
    summarize(value_sum = sum(value), .by = c("companies_id", "grouped_by"))

  expect_true(all(sum$value_sum == 1))
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

  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  expect_true(all(is.na(out$value)))
})

test_that("values sum 1", {
  

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
    type = "a",
    sector = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )

  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)
  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  

  companies <- tibble(
    company_id = "a",
    type = "a",
    sector = c("a", "unmatched"),
    subsector = "a",
    clustered = c("a", "b"),
    activity_uuid_product_uuid = c("a", "b"),
    tilt_sector = "a",
    tilt_subsector = "a",
  )
  scenarios <- tibble(
    type = "a",
    sector = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )

  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)

  expect_equal(nrow(out), 3L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 3L)
  expect_false(anyNA(out))
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  

  companies <- tibble(
    company_id = "a",
    type = "a",
    sector = "unmatched",
    subsector = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a",
    tilt_sector = "a",
    tilt_subsector = "a",
  )
  scenarios <- tibble(
    type = "a",
    sector = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )

  product <- pstr_at_product_level(companies, scenarios)
  out <- pstr_at_company_level(product)

  expect_equal(nrow(out), 1)
  expect_equal(out$companies_id, "a")
  expect_true(is.na(out$value))
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$grouped_by))
})

test_that("hasn't changed", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs expected columns at company level", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("the output is not grouped", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("thresholds yield expected low, medium, and high risk categories", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  default_low_mid <- 1 / 3
  product <- sector_profile_upstream_at_product_level(companies, mutate(scenarios, reductions = default_low_mid), inputs)
  out <- any_at_company_level(product)
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_low_mid <- 1 / 3 + 0.001
  product <- sector_profile_upstream_at_product_level(companies, mutate(scenarios, reductions = above_default_low_mid), inputs)
  out <- any_at_company_level(product)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  default_mid_high <- 2 / 3
  product <- sector_profile_upstream_at_product_level(companies, mutate(scenarios, reductions = default_mid_high), inputs)
  out <- any_at_company_level(product)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(1, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)

  above_default_mid_high <- 2 / 3 + 0.001
  product <- sector_profile_upstream_at_product_level(companies, mutate(scenarios, reductions = above_default_mid_high), inputs)
  out <- any_at_company_level(product)
  expect_equal(0, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(1, filter(out, risk_category == "high")$value)

  below_0 <- -0.001
  product <- sector_profile_upstream_at_product_level(companies, mutate(scenarios, reductions = below_0), inputs)
  out <- any_at_company_level(product)
  expect_equal(1, filter(out, risk_category == "low")$value)
  expect_equal(0, filter(out, risk_category == "medium")$value)
  expect_equal(0, filter(out, risk_category == "high")$value)
})

test_that("outputs values in proportion", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()
  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  expect_true(all(na.omit(out$value) <= 1.0))
})

test_that("each company has risk categories low, medium, and high (#215)", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  risk_categories <- sort(unique(out$risk_category))

  expect_equal(risk_categories, c("high", "low", "medium"))
})

test_that("grouped_by includes the type of scenario", {
  companies <- example_companies()
  .type <- "ipr"
  scenarios <- example_scenarios(!!aka("scenario_type") := .type)
  inputs <- example_inputs(!!aka("scenario_type") := .type)

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  expect_true(all(grepl(.type, unique(out$grouped_by))))
})

test_that("with type ipr, for each company and grouped_by value sums 1 (#216)", {
  .type <- "ipr"
  companies <- example_companies(!!aka("scenario_type") := .type)
  scenarios <- example_scenarios(!!aka("scenario_type") := .type)
  inputs <- example_inputs(!!aka("scenario_type") := .type)

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  sum <- out |>
    summarize(value_sum = sum(value), .by = cols_by())

  expect_true(all(na.omit(sum$value_sum) |> near(1)))
})

test_that("with type weo, for each company and grouped_by value sums 1 (#308)", {
  .type <- "weo"
  companies <- example_companies(!!aka("scenario_type") := .type)
  scenarios <- example_scenarios(!!aka("scenario_type") := .type)
  inputs <- example_inputs(!!aka("scenario_type") := .type)

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  sum <- out |>
    summarize(value_sum = sum(value), .by = cols_by())

  expect_true(all(na.omit(sum$value_sum) |> near(1)))
})

test_that("NA in reductions yields expected risk_category and NAs in value (#300)", {
  companies <- example_companies()
  # FIXME: Passes even if reductions is not NA
  scenarios <- example_scenarios(!!aka("co2reduce") := NA)
  inputs <- example_inputs()

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  expect_true(all(is.na(out$value)))
})

test_that("values sum 1", {
  scenarios <- example_scenarios()
  companies <- example_companies()
  inputs <- example_inputs()

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)
  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs(!!aka("xsubsector") := c("energy", "unmatched"))

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)

  expect_equal(nrow(out), 3L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 3L)
  expect_false(anyNA(out))
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs(!!aka("xsector") := "unmatched")

  product <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  out <- any_at_company_level(product)

  expect_equal(nrow(out), 1)
  expect_equal(out$companies_id, "a")
  expect_true(is.na(out$value))
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$grouped_by))
})

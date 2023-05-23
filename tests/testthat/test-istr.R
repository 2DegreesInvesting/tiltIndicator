test_that("outputs expected columns at company level", {
  companies <- slice(istr_companies, 1)
  scenarios <- slice(istr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)

  out <- istr(companies, scenarios, inputs)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
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

  inputs <- tibble(
    activity_uuid_product_uuid = "x",
    input_activity_uuid_product_uuid = "y",
    input_reference_product_name = "y",
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

  inputs <- tibble(
    activity_uuid_product_uuid = "x",
    input_activity_uuid_product_uuid = "y",
    input_reference_product_name = "y",
    input_unit = "y",
    input_isic_4digit = "y",
    type = "a",
    sector = "b",
    subsector = "c"
  )

  out <- istr(companies, scenarios, inputs)
  expect_true(all(is.na(out$value)))
})

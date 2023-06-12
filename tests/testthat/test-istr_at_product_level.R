test_that("outputs expected columns at product level", {
  companies <- slice(istr_companies, 1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs
  out <- istr_at_product_level(companies, scenarios, inputs)
  expect_named(out, istr_cols_at_product_level())
})

test_that("`low_threshold` and `year` yield the expected risk categories", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "any",
    clustered = "any",
    activity_uuid_product_uuid = "any"
  )

  between_high_2030_and_other_years <- 0.2
  scenarios <- tibble(
    reductions = between_high_2030_and_other_years,
    scenario = "1.5c required policy scenario",
    sector = "total",
    subsector = "energy",
    year = c(2030, 2050),
    type = "ipr",
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

  out <- istr_at_product_level(companies, scenarios, inputs)

  # Reductions > low = "medium"
  expect_equal(filter(out, year == 2030)$risk_category, "medium")
  # Reductions < low = "low"
  expect_equal(filter(out, year != 2030)$risk_category, "low")
})

test_that("`high_threshold` and `year` yield the expected risk categories", {
  companies <- tibble(
    company_id = "a",
    tilt_sector = "any",
    clustered = "any",
    activity_uuid_product_uuid = "any"
  )

  between_high_2030_and_other_years <- 0.4
  scenarios <- tibble(
    reductions = between_high_2030_and_other_years,
    scenario = "1.5c required policy scenario",
    sector = "total",
    subsector = "energy",
    year = c(2030, 2050),
    type = "ipr",
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

  out <- istr_at_product_level(companies, scenarios, inputs)

  # Reductions > threshold = "high"
  expect_equal(filter(out, year == 2030)$risk_category, "high")
  # Reductions < threshold = "medium"
  expect_equal(filter(out, year != 2030)$risk_category, "medium")
})

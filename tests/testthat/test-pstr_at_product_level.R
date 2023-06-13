test_that("outputs expected columns at product level", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  out <- pstr_at_product_level(companies, scenarios)
  expect_named(out, pstr_cols_at_product_level())
})

test_that("`low_threshold` and `year` yield the expected risk categories", {
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

  between_low_2030_and_other_years <- 0.2
  scenarios <- tibble(
    reductions = between_low_2030_and_other_years,
    year = c(2030, 2050),
    scenario = "1.5c required policy scenario",
    sector = "total",
    subsector = "energy",
    type = "ipr",
  )

  out <- pstr_at_product_level(companies, scenarios)

  # Reductions > low = "medium"
  expect_equal(filter(out, year == 2030)$risk_category, "medium")
  # Reductions < low = "low"
  expect_equal(filter(out, year != 2030)$risk_category, "low")
})

test_that("`high_threshold` and `year` yield the expected risk categories", {
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

  between_high_2030_and_other_years <- 0.4
  scenarios <- tibble(
    reductions = between_high_2030_and_other_years,
    year = c(2030, 2050),
    scenario = "1.5c required policy scenario",
    sector = "total",
    subsector = "energy",
    type = "ipr",
  )

  out <- pstr_at_product_level(companies, scenarios)

  # Reductions > threshold = "high"
  expect_equal(filter(out, year == 2030)$risk_category, "high")
  # Reductions < threshold = "medium"
  expect_equal(filter(out, year != 2030)$risk_category, "medium")
})

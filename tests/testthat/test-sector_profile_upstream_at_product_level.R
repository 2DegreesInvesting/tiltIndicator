test_that("outputs expected columns at product level", {
  companies <- slice(istr_companies, 1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs
  out <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
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

  out <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)

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

  out <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)

  # Reductions > threshold = "high"
  expect_equal(filter(out, year == 2030)$risk_category, "high")
  # Reductions < threshold = "medium"
  expect_equal(filter(out, year != 2030)$risk_category, "medium")
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

  out <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)
  expect_equal(out$risk_category, NA_character_)
})

test_that("some match yields no NA and no match yields 1 row with `NA`s (#393)", {
  companies <- tibble(
    company_id = c("a", "a", "b", "b"),
    tilt_sector = "a",
    clustered = c("matched", paste0("unmatched", 1:3)),
    activity_uuid_product_uuid = c("matched", paste0("unmatched", 1:3))
  )
  scenarios <- tibble(
    type = "a",
    sector = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "matched",
    input_activity_uuid_product_uuid = "a",
    input_tilt_sector = "a",
    input_tilt_subsector = "a",
    type = "a",
    sector = "a",
    subsector = "a",
    input_unit = "a",
    input_isic_4digit = "1234",
  )

  out <- sector_profile_upstream_at_product_level(companies, scenarios, inputs)

  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  na_cols <- setdiff(cols_at_product_level(), "companies_id")
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("with duplicated scenarios throws no error (#435)", {
  duplicated <- c("a", "a")
  scenarios <- tibble(
    sector = duplicated,
    type = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
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
    input_isic_4digit = "1234",
  )

  expect_no_error(sector_profile_upstream_at_product_level(companies, scenarios, inputs))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(bad, scenarios, inputs), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(bad, scenarios, inputs), crucial)
})

test_that("if `scenarios` lacks crucial columns, errors gracefully", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  crucial <- "type"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, bad, inputs), crucial)

  crucial <- "sector"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, bad, inputs), crucial)

  crucial <- "subsector"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, bad, inputs), crucial)

  crucial <- "year"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, bad, inputs), crucial)

  crucial <- "scenario"
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, bad, inputs), crucial)
})

test_that("if `inputs` lacks crucial columns, errors gracefully", {
  companies <- istr_companies |> slice(1)
  scenarios <- xstr_scenarios
  inputs <- istr_inputs

  crucial <- "type"
  bad <- select(inputs, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, scenarios, bad), crucial)

  crucial <- "sector"
  bad <- select(inputs, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, scenarios, bad), crucial)

  crucial <- "subsector"
  bad <- select(inputs, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, scenarios, bad), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(inputs, -all_of(crucial))
  expect_error(sector_profile_upstream_at_product_level(companies, scenarios, bad), crucial)
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
  expect_error(sector_profile_upstream_at_product_level(companies, scenarios, inputs), "sector.*subsector.*type")
})

test_that("a 0-row `companies` yields an error", {
  expect_error(
    sector_profile_upstream_at_product_level(istr_companies[0L, ], xstr_scenarios, istr_inputs),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `scenarios` yields an error", {
  expect_error(
    sector_profile_upstream_at_product_level(istr_companies, xstr_scenarios[0L, ], istr_inputs),
    "scenarios.*can't have 0-row"
  )
})

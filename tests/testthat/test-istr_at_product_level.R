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

  out <- istr_at_product_level(companies, scenarios, inputs)
  expect_equal(out$risk_category, NA_character_)
})

# test_that("some match yield no NA and no match yields 1 row with `NA`s (#393)", {
test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- tibble(
    company_id = c("a", "a", "b", "b"),
    tilt_sector = "a",
    clustered = letters[1:4],
    activity_uuid_product_uuid = letters[1:4]
  )

  scenarios <- tibble(
    type = "a",
    sector = c("matched", "unmatched", "unmatched", "unmatched"),
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )

  inputs <- tibble(
    activity_uuid_product_uuid = "a",
    input_activity_uuid_product_uuid = "a",
    input_tilt_sector = "a",
    input_tilt_subsector = "a",
    type = "a",
    sector = "matched",
    subsector = "a",
    input_unit = "a",
    input_isic_4digit = "a",
  )

  # FIXME: use defaults after fixing #435
  out <- istr_at_product_level(companies, scenarios, inputs, 1/3, 2/3)
  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  # FIXME Uncomment
  # no_match <- filter(out, companies_id == "b")
  # expect_equal(nrow(no_match), 1)
  #
  # na_cols <- setdiff(cols_at_product_level(), "companies_id")
  # all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  # expect_true(all_na_cols_are_na)

})

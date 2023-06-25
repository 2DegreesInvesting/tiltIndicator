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

  out <- pstr_at_product_level(companies, scenarios)
  expect_equal(out$risk_category, NA_character_)
})

test_that("some match yields no NA and no match yields 1 row with `NA`s (#393)", {
  companies <- tibble(
    company_id = c("a", "a", "b", "b"),
    sector = c("matched", "unmatched", "unmatched", "unmatched"),
    type = "a",
    subsector = "a",
    clustered = letters[1:4],
    activity_uuid_product_uuid = letters[1:4],
    tilt_sector = "a",
    tilt_subsector = "a",
  )
  scenarios <- tibble(
    sector = "matched",
    type = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )

  out <- pstr_at_product_level(companies, scenarios)
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
    type = duplicated,
    sector = "a",
    subsector = "a",
    scenario = "a",
    year = 2050,
    reductions = 1,
  )
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

  expect_no_error(pstr_at_product_level(companies, scenarios))
})

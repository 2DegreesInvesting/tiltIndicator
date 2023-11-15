test_that("outputs expected columns at product level", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  out <- sector_profile_at_product_level(companies, scenarios)
  expect_named(out, sp_cols_at_product_level())
})

test_that("`low_threshold` and `year` yield the expected risk categories", {
  companies <- example_companies()

  between_low_2030_and_other_years <- 0.2
  scenarios <- example_scenarios(
    !!aka("co2reduce") := between_low_2030_and_other_years,
    !!aka("xyear") := c(2030, 2050)
  )

  out <- sector_profile_at_product_level(companies, scenarios)

  # Reductions > low = "medium"
  expect_equal(filter(out, year == 2030)$risk_category, "medium")
  # Reductions < low = "low"
  expect_equal(filter(out, year != 2030)$risk_category, "low")
})

test_that("`high_threshold` and `year` yield the expected risk categories", {
  companies <- example_companies()

  between_high_2030_and_other_years <- 0.4
  scenarios <- example_scenarios(
    !!aka("co2reduce") := between_high_2030_and_other_years,
    !!aka("xyear") := c(2030, 2050)
  )

  out <- sector_profile_at_product_level(companies, scenarios)

  # Reductions > threshold = "high"
  expect_equal(filter(out, year == 2030)$risk_category, "high")
  # Reductions < threshold = "medium"
  expect_equal(filter(out, year != 2030)$risk_category, "medium")
})

test_that("NA in the reductions column yields `NA` in risk_category at product level", {
  companies <- example_companies()
  scenarios <- example_scenarios(!!aka("co2reduce") := NA)

  out <- sector_profile_at_product_level(companies, scenarios)
  expect_equal(out$risk_category, NA_character_)
})

test_that("some match yields no NA and no match yields 1 row with `NA`s (#393)", {
  companies <- example_companies(
    !!aka("id") := c("a", "a", "b", "b"),
    !!aka("uid") := c("a", "b", "c", "d"),
    !!aka("cluster") := c("a", "b", "c", "d"),
    !!aka("xsector") := c("total", "unmatched", "unmatched", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile_at_product_level(companies, scenarios)
  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  cols_not_na <- function() {
    c("companies_id", "clustered")
  }
  na_cols <- setdiff(cols_at_product_level(), cols_not_na())
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("with duplicated scenarios throws no error (#435)", {
  companies <- example_companies()
  duplicated <- c("a", "a")
  scenarios <- example_scenarios(!!aka("scenario_type") := duplicated)

  expect_no_error(sector_profile_at_product_level(companies, scenarios))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  crucial <- aka("id")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_at_product_level(bad, scenarios), crucial)

  crucial <- aka("scenario_type")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_at_product_level(bad, scenarios), crucial)

  crucial <- aka("xsector")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_at_product_level(bad, scenarios), crucial)

  crucial <- aka("xsubsector")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_at_product_level(bad, scenarios), crucial)
})

test_that("if `scenarios` lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  crucial <- aka("scenario_type")
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_at_product_level(companies, bad), crucial)

  crucial <- aka("xsector")
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_at_product_level(companies, bad), crucial)

  crucial <- aka("xsubsector")
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_at_product_level(companies, bad), crucial)

  crucial <- aka("xyear")
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_at_product_level(companies, bad), crucial)

  crucial <- aka("scenario_name")
  bad <- select(scenarios, -all_of(crucial))
  expect_error(sector_profile_at_product_level(companies, bad), crucial)
})

test_that("grouped_by includes the type of scenario", {
  .type <- "ipr"
  companies <- example_companies(!!aka("scenario_type") := .type)
  scenarios <- example_scenarios(!!aka("scenario_type") := .type)

  product <- sector_profile_at_product_level(companies, scenarios)
  out <- any_at_company_level(product)

  expect_true(all(grepl(.type, unique(out$grouped_by))))
})

test_that("error if a `type` has all `NA` in `sector` & `subsector` (#310)", {
  companies <- example_companies()
  bad <- c(NA_character_, NA_character_, "a", "a")
  scenarios <- example_scenarios(
    !!aka("scenario_type") := c("a", "a", "b", "b"),
    !!aka("xsector") := bad,
    !!aka("xsubsector") := bad
  )

  expect_error(sector_profile_at_product_level(companies, scenarios), "sector.*subsector.*type")
})

test_that("a 0-row `companies` yields an error", {
  companies <- example_companies()[0L, ]
  scenarios <- example_scenarios()

  expect_error(
    sector_profile_at_product_level(companies, scenarios),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `scenarios` yields an error", {
  companies <- example_companies()
  scenarios <- example_scenarios()[0L, ]
  expect_error(
    sector_profile_at_product_level(companies, scenarios),
    "scenario.*can't have 0-row"
  )
})

test_that("with ';' in `*sector` throws an warning", {
  bad <- "a; b"
  companies <- example_companies(!!aka("xsector") := bad)
  scenarios <- example_scenarios()

  expect_snapshot_warning(sector_profile_at_product_level(companies, scenarios))
})

test_that("`*rowid` columns are passed to the output", {
  companies <- example_companies(companies_rowid = 1)
  scenarios <- example_scenarios(scenarios_rowid = 1)

  out <- sector_profile_at_product_level(companies, scenarios)
  expect_true(hasName(out, "companies_rowid"))
  expect_true(hasName(out, "scenarios_rowid"))
})

test_that("the same `*rowid` in multiple tables yields an error", {
  companies <- example_companies(xrowid = 1)
  scenarios <- example_scenarios(xrowid = 1)

  expect_error(
    sector_profile_at_product_level(companies, scenarios),
    "rowid.*must be different"
  )
})

test_that("with just one `*rowid` name throws no an error", {
  companies <- example_companies(xrowid = 1)
  scenarios <- example_scenarios()

  expect_no_error(
    sector_profile_at_product_level(companies, scenarios)
  )
})

test_that("with the reserved name `rowid` throws an error", {
  companies <- example_companies(rowid = 1)
  scenarios <- example_scenarios()

  expect_error(
    sector_profile_at_product_level(companies, scenarios),
    "rowid.*reserved"
  )
})

test_that("`*rowid` columns are passed through inputs with duplicates", {
  companies <- example_companies(companies_rowid = 1:2)
  scenarios <- example_scenarios(scenarios_rowid = 1:2)

  out <- sector_profile_at_product_level(companies, scenarios)
  expect_true(hasName(out, "companies_rowid"))
  expect_true(hasName(out, "scenarios_rowid"))
})

test_that("yields non-missing `clustered` when `risk_category` is `NA` (#587)", {
  companies <- example_companies(type = NA)
  scenarios <- example_scenarios()
  out <- sector_profile_at_product_level(companies, scenarios)
  expect_false(is.na(out$clustered))
})

test_that("with products, if data lacks crucial columns, errors gracefully", {
  data <- example_emissions_profile() |> unnest_product()

  crucial <- "grouped_by"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_co2_range(bad), crucial)

  crucial <- "risk_category"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_co2_range(bad), crucial)

  crucial <- find_co2_footprint(data)
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_co2_range(bad), crucial)
})

test_that("with inputs, if data lacks crucial columns, errors gracefully", {
  data <- example_emissions_profile_upstream() |> unnest_product()

  crucial <- "grouped_by"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_co2_range(bad), crucial)

  crucial <- "risk_category"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_co2_range(bad), crucial)

  crucial_pattern <- aka("co2footprint")
  bad <- select(data, -matches(crucial_pattern))
  expect_error(jitter_co2_range(bad), crucial_pattern)
})

test_that("with products, adds the new columns `lower` and `upper`", {
  data <- example_emissions_profile() |> unnest_product()

  out <- jitter_co2_range(data)

  expect_true(hasName(out, "lower"))
  expect_true(hasName(out, "upper"))
})

test_that("with inputs, adds the new columns `lower` and `upper`", {
  data <- example_emissions_profile_upstream() |> unnest_product()

  out <- jitter_co2_range(data)

  expect_true(hasName(out, "lower"))
  expect_true(hasName(out, "upper"))
})

test_that("outputs one row for each values of `grouped_by` and `risk_category`", {
  companies <- example_companies(!!aka("id") := 1:2)
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()

  out <- jitter_co2_range(data)
  expected <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(nrow(out), expected)
})

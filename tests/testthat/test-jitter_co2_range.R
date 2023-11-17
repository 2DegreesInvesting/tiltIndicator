test_that("with products, if data lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  co2 <- example_products()
  data <- unnest_product(emissions_profile_upstream(companies, co2))

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
  companies <- example_companies()
  co2 <- example_inputs()
  data <- unnest_product(emissions_profile_upstream(companies, co2))

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

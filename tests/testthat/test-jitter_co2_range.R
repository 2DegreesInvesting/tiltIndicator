test_that("if data lacks crucial columns, errors gracefully", {
  data <- emissions_profile(example_companies(), example_products()) |>
    unnest_product() |>
    slice(1)

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

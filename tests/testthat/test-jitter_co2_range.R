test_that("if data lacks crucial columns, errors gracefully", {
  data <- tribble(
    ~grouped_by, ~risk_category, ~co2_footprint,
          "all",         "high",            "1"
  )

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

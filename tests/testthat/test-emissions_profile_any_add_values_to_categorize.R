test_that("works with benchmark columns matching a general pattern", {
  co2 <- example_products()
  expect_no_error(emissions_profile_any_add_values_to_categorize(co2))

  co2 <- example_inputs()
  expect_no_error(emissions_profile_any_add_values_to_categorize(co2))
})

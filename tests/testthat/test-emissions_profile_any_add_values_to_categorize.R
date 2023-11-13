test_that("works with any 'co2-like' dataset", {
  co2 <- example_products()
  expect_no_error(emissions_profile_any_add_values_to_categorize(co2))

  co2 <- example_inputs()
  expect_no_error(emissions_profile_any_add_values_to_categorize(co2))
})

test_that("adds columns `grouped_by` and `values_to_categorize`", {
  co2 <- example_products()

  out <- emissions_profile_any_add_values_to_categorize(co2)

  new_names <- c("grouped_by", "values_to_categorize")
  expect_equal(setdiff(names(out), names(co2)), new_names)
})

test_that("adds columns `grouped_by` and `values_to_categorize` to the left", {
  co2 <- example_products()

  out <- emissions_profile_any_add_values_to_categorize(co2)

  new_names <- c("grouped_by", "values_to_categorize")
  expect_equal(names(out)[1:2], new_names)
})

test_that("with one company, adds one row per benchmark per company", {
  co2 <- example_products()

  out <- emissions_profile_any_add_values_to_categorize(co2)

  number_of_benchmarks <- length(flat_benchmarks(co2))
  expect_equal(nrow(out), number_of_benchmarks)
})

test_that("with two companies, adds one row per benchmark per company", {
  co2 <- example_products(!!aka("id") := c("a", "b"))

  out <- emissions_profile_any_add_values_to_categorize(co2)

  number_of_benchmarks <- length(flat_benchmarks(co2))
  expect_equal(nrow(out), 2 * number_of_benchmarks)
})

test_that("without crucial columns errors gracefully", {
  co2 <- example_products()

  crucial <- aka("tsector")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_add_values_to_categorize(bad), crucial)

  crucial <- aka("xunit")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_add_values_to_categorize(bad), crucial)

  crucial <- aka("isic")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_add_values_to_categorize(bad), crucial)

  crucial <- aka("co2footprint")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_add_values_to_categorize(bad), crucial)
})

test_that("if `values_to_categorize` is present, `grouped_by` must be present", {
  co2 <- example_products(values_to_categorize = 1)
  crucial <- "grouped_by"
  expect_error(emissions_profile_any_add_values_to_categorize(co2), crucial)
})

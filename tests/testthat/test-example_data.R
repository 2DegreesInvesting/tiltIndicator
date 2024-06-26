test_that("example_inputs() has the expected names", {
  emissions <- names(read_test_csv(toy_emissions_profile_upstream_products_ecoinvent()))
  sector <- names(read_test_csv(toy_sector_profile_upstream_products()))
  reference <- unique(c(emissions, sector))
  expect_true(all(names(example_inputs()) %in% reference))
})

test_that("example_inputs() adds a row", {
  expect_equal(nrow(example_inputs(1:2)), 2L)
})

test_that("example_inputs() adds a column", {
  expect_true(hasName(example_inputs(new = 1), "new"))
})

test_that("example_inputs() adds columns via alias", {
  out <- example_inputs(!!aka("id") := 1:2)
  expect_equal(out[[aka("id")]], 1:2)
})

test_that("example_inputs() single-quotes *isic* values", {
  value <- pull_isic(example_inputs())
  expect_equal(value, "'1234'")
})

test_that("example_products() has the expected names", {
  reference <- names(read_test_csv(toy_emissions_profile_products_ecoinvent()))
  expect_true(all(names(example_products()) %in% reference))
})

test_that("example_products() adds a row", {
  expect_equal(nrow(example_products(1:2)), 2L)
})

test_that("example_products() adds a column", {
  expect_true(hasName(example_products(new = 1), "new"))
})

test_that("example_products() adds columns via alias", {
  out <- example_products(!!aka("id") := 1:2)
  expect_equal(out[[aka("id")]], 1:2)
})

test_that("example_products() single-quotes *isic* values", {
  value <- pull_isic(example_products())
  expect_equal(value, "'1234'")
})

test_that("example_scenarios() has the expected names", {
  reference <- names(read_test_csv(toy_sector_profile_any_scenarios()))
  expect_true(all(names(example_scenarios()) %in% reference))
})

test_that("example_scenarios() adds a row", {
  expect_equal(nrow(example_scenarios(1:2)), 2L)
})

test_that("example_scenarios() adds a column", {
  expect_true(hasName(example_scenarios(new = 1), "new"))
})

test_that("example_scenarios() adds columns via alias", {
  out <- example_scenarios(!!aka("id") := 1:2)
  expect_equal(out[[aka("id")]], 1:2)
})

test_that("example_companies() has the expected names", {
  reference <- names(read_test_csv(toy_sector_profile_companies()))
  expect_true(all(names(example_companies()) %in% reference))
})

test_that("example_companies() adds a row", {
  expect_equal(nrow(example_companies(1:2)), 2L)
})

test_that("example_companies() adds a column", {
  expect_true(hasName(example_companies(new = 1), "new"))
})

test_that("example_companies() adds columns via alias", {
  out <- example_companies(!!aka("id") := 1:2)
  expect_equal(out[[aka("id")]], 1:2)
})

test_that("example_products() has co2 data of class 'double'", {
  out <- example_products()
  expect_type(out[[find_co2_footprint(out)]], "double")
})

test_that("example_inputs() has co2 data of class 'double'", {
  out <- example_inputs()
  expect_type(out[[find_co2_footprint(out)]], "double")
})

test_that("example_products() has column 'tilt_subsector'", {
  out <- example_products()
  expect_true(hasName(out, "tilt_subsector"))
})

test_that("returns visibly (#238)", {
  companies <- example_companies()
  inputs <- example_inputs()
  expect_visible(emissions_profile_any_at_product_level(companies, inputs))
  products <- example_products()
  expect_visible(emissions_profile_any_at_product_level(companies, products))
})

test_that("outputs expected columns at product level", {
  companies <- example_companies()

  inputs <- example_inputs()
  expected <- c(cols_at_product_level(), aka("iuid"), aka("ico2footprint"))
  out <- emissions_profile_any_at_product_level(companies, inputs)
  expect_named(out, expected)

  products <- example_products()
  expected <- c(cols_at_product_level(), aka("co2footprint"))
  out <- emissions_profile_any_at_product_level(companies, products)
  expect_named(out, expected)
})

test_that("with duplicated co2 throws no error (#435)", {
  companies <- example_companies()
  duplicated <- c("a", "a")
  products <- example_products(!!aka("uid") := duplicated)

  expect_no_error(emissions_profile_any_at_product_level(companies, products))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  products <- example_products()

  crucial <- aka("uid")
  bad <- select(companies, -all_of(crucial))
  expect_error(emissions_profile_any_at_product_level(bad, products), crucial)

  crucial <- aka("id")
  bad <- select(companies, -all_of(crucial))
  expect_error(
    emissions_profile_any_at_product_level(bad, products),
    class = "check_matches_name"
  )
})

test_that("if `co2` lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  products <- example_products()

  crucial <- aka("co2footprint")
  bad <- select(products, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("tsector")
  bad <- select(products, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("xunit")
  bad <- select(products, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("uid")
  bad <- select(products, -all_of(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("isic")
  bad <- select(products, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)
})

test_that("handles duplicated `companies` data (#230)", {
  companies <- example_companies(!!aka("id") := c("a", "a"))
  products <- example_products()
  expect_no_error(emissions_profile_any_at_product_level(companies, products))
})

test_that("handles duplicated `co2` data (#230)", {
  companies <- example_companies()
  duplicated <- c("a", "a")
  products <- example_products(!!aka("uid") := duplicated)
  expect_no_error(emissions_profile_any_at_product_level(companies, products))
})

test_that("if 'isic' column is numeric it knows how to handle it gracefully", {
  companies <- example_companies()
  numeric <- 1234
  products <- example_products(!!aka("isic") := numeric)
  expect_no_error(emissions_profile_any_at_product_level(companies, products))
})

test_that("if the 'isic' column hasn't 4 digits throws no error", {
  companies <- example_companies()
  products <- example_products(!!aka("isic") := c(NA, "1", "12", "123", "12345"))
  expect_no_error(emissions_profile_any_at_product_level(companies, products))
})

test_that("a 0-row `co2` yields an error", {
  companies <- example_companies()
  products <- example_products()
  expect_error(
    emissions_profile_any_at_product_level(companies[0L, ], products),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `co2` yields an error", {
  companies <- example_companies()
  products <- example_products()[0L, ]
  expect_error(
    emissions_profile_any_at_product_level(companies, products),
    "co2.*can't have 0-row"
  )
})

test_that("a 0-row `companies` yields an error", {
  companies <- example_companies()
  inputs <- example_inputs()
  expect_error(
    emissions_profile_any_at_product_level(companies[0L, ], inputs),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `inputs` yields an error", {
  companies <- example_companies()
  inputs <- example_inputs()[0L, ]
  expect_error(
    emissions_profile_any_at_product_level(companies, inputs),
    "co2.*can't have 0-row"
  )
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  inputs <- example_inputs()

  crucial <- aka("uid")
  bad <- select(companies, -all_of(crucial))
  expect_error(emissions_profile_any_at_product_level(bad, inputs), crucial)

  crucial <- aka("id")
  bad <- select(companies, -all_of(crucial))
  expect_error(
    emissions_profile_any_at_product_level(bad, inputs),
    class = "check_matches_name"
  )
})

test_that("if `inputs` lacks crucial columns, errors gracefully", {
  companies <- example_companies()
  inputs <- example_inputs()

  crucial <- aka("uid")
  bad <- select(inputs, -all_of(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("co2footprint")
  bad <- select(inputs, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("xunit")
  bad <- select(inputs, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("tsector")
  bad <- select(inputs, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)

  crucial <- aka("isic")
  bad <- select(inputs, -ends_with(crucial))
  expect_error(emissions_profile_any_at_product_level(companies, bad), crucial)
})

test_that("handles duplicated `companies` data (#230)", {
  duplicated <- c("a", "a")
  companies <- example_companies(!!aka("id") := duplicated)
  inputs <- example_inputs()
  expect_no_error(emissions_profile_any_at_product_level(companies, inputs))
})

test_that("handles duplicated `co2` data (#230)", {
  companies <- example_companies()
  duplicated <- c("a", "a")
  inputs <- example_inputs(!!aka("uid") := duplicated)
  expect_no_error(emissions_profile_any_at_product_level(companies, inputs))
})

test_that("with a missing value in the co2* column errors gracefully", {
  companies <- example_companies()
  inputs <- example_inputs()
  inputs$input_co2_footprint <- NA
  expect_error(emissions_profile_any_at_product_level(companies, inputs), aka("co2footprint"))
})

test_that("`*rowid` columns are passed to the output", {
  companies <- example_companies(companies_rowid = 1)

  products <- example_inputs(products_rowid = 1)
  out <- emissions_profile_any_at_product_level(companies, products)
  expect_true(hasName(out, "companies_rowid"))
  expect_true(hasName(out, "products_rowid"))

  inputs <- example_inputs(inputs_rowid = 1)
  out <- emissions_profile_any_at_product_level(companies, inputs)
  expect_true(hasName(out, "companies_rowid"))
  expect_true(hasName(out, "inputs_rowid"))
})

test_that("the same `*rowid` in multiple tables yields an error", {
  companies <- example_companies(xrowid = 1)
  products <- example_products(xrowid = 1)

  expect_error(
    emissions_profile_any_at_product_level(companies, products),
    "rowid.*must be different"
  )
})

test_that("with just one `*rowid` name throws no an error", {
  companies <- example_companies(xrowid = 1)
  products <- example_products()

  expect_no_error(
    emissions_profile_any_at_product_level(companies, products)
  )
})

test_that("with the reserved name `rowid` throws an error", {
  companies <- example_companies(rowid = 1)
  products <- example_products()

  expect_error(
    emissions_profile_any_at_product_level(companies, products),
    "rowid.*reserved"
  )
})

test_that("`*rowid` columns are passed through inputs with duplicates", {
  companies <- example_companies(companies_rowid = 1:2)
  products <- example_products(products_rowid = 1:2)

  out <- emissions_profile_any_at_product_level(companies, products)
  expect_true(hasName(out, "companies_rowid"))
  expect_true(hasName(out, "products_rowid"))
})

test_that("yields non-missing `clustered` when `risk_category` is `NA` (#587)", {
  products <- example_products()
  companies <- example_companies(!!aka("uid") := NA)
  out <- emissions_profile_any_at_product_level(companies, products)
  expect_true(is.na(out$risk_category))
  expect_false(is.na(out$clustered))

  inputs <- example_inputs()
  companies <- example_companies(!!aka("uid") := NA)
  out <- emissions_profile_any_at_product_level(companies, inputs)
  expect_true(is.na(out$risk_category))
  expect_false(is.na(out$clustered))
})

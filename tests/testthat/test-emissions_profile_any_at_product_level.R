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

test_that("unmatched products don't introduce NA's (#266)", {
  companies <- example_companies(!!aka("uid") := c("a", "unmatched"))

  products <- example_products()
  out <- emissions_profile_any_at_product_level(companies, products)
  expect_false(anyNA(out$risk_category))

  inputs <- example_inputs()
  out <- emissions_profile_any_at_product_level(companies, inputs)
  expect_false(anyNA(out$risk_category))
})

test_that("some match yields no NA and no match yields 1 row with `NA`s (#393)", {
  companies <- example_companies(
    !!aka("id") := c("a", "a", "b", "b"),
    !!aka("uid") := c("a", paste0("unmatched", 1:3))
  )

  products <- example_products()
  out <- emissions_profile_any_at_product_level(companies, products)

  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  na_cols <- setdiff(cols_at_product_level(), "companies_id")
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)

  inputs <- example_inputs()
  out <- emissions_profile_any_at_product_level(companies, inputs)

  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  na_cols <- setdiff(cols_at_product_level(), "companies_id")
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)
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
  expect_error(emissions_profile_any_at_product_level(bad, products), crucial)
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

test_that("if the 'isic' column hasn't 4 digits throws an errors ", {
  companies <- example_companies()
  products <- example_products()
  expect_no_error(emissions_profile_any_at_product_level(companies, products))

  products$isic_4digit <- "1"
  expect_error(emissions_profile_any_at_product_level(companies, products), "must.*4")
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
  expect_error(emissions_profile_any_at_product_level(bad, inputs), crucial)
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
  inputs <- example_inputs(!!aka("id") := duplicated)
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

test_that("with products, uses `co2$profile_ranking` if present (#603)", {
  companies <- example_companies()
  co2 <- example_products(!!aka("uid") := c("a", "b"))
  co2[extract_name(co2, aka("co2footprint"))] <- 1:2

  lacks_profile_ranking <- !hasName(co2, "profile_ranking")
  stopifnot(lacks_profile_ranking)
  out1 <- emissions_profile_any_at_product_level(companies, co2)
  using_computed_values <- unique(out1$risk_category)

  pre_computed <- emissions_profile_any_compute_profile_ranking(co2)
  has_profile_ranking <- hasName(pre_computed, "profile_ranking")
  stopifnot(has_profile_ranking)

  yields_a_different_risk_category <- 999
  pre_computed$profile_ranking <- yields_a_different_risk_category
  out2 <- emissions_profile_any_at_product_level(companies, pre_computed)
  using_pre_computed_values <- unique(out2$risk_category)

  expect_false(identical(using_computed_values, using_pre_computed_values))
})

test_that("with inputs, uses `co2$profile_ranking` if present (#603)", {
  companies <- example_companies()
  co2 <- example_inputs(!!aka("uid") := c("a", "b"))
  # This is wrong: names(example_inputs(!!aka("co2footprint") := 1:2))
  # It yields two columns: `co2_footprint` AND `input_co2_footprint`
  co2[extract_name(co2, aka("co2footprint"))] <- 1:2

  lacks_profile_ranking <- !hasName(co2, "profile_ranking")
  stopifnot(lacks_profile_ranking)
  out1 <- emissions_profile_any_at_product_level(companies, co2)
  using_computed_values <- unique(out1$risk_category)

  pre_computed <- emissions_profile_any_compute_profile_ranking(co2)
  has_profile_ranking <- hasName(pre_computed, "profile_ranking")
  stopifnot(has_profile_ranking)

  yields_a_different_risk_category <- 999
  pre_computed$profile_ranking <- yields_a_different_risk_category
  out2 <- emissions_profile_any_at_product_level(companies, pre_computed)
  using_pre_computed_values <- unique(out2$risk_category)

  expect_false(identical(using_computed_values, using_pre_computed_values))
})

test_that("yields non-missing `clustered` when `risk_category` is `NA` (#587)", {
  companies <- example_companies(!!aka("uid") := NA)
  co2 <- example_products()

  out <- emissions_profile_any_at_product_level(companies, co2)

  expect_true(is.na(out$risk_category))
  expect_false(is.na(out$clustered))
})

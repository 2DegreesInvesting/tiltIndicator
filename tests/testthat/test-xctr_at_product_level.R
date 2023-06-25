test_that("returns visibly (#238)", {
  companies <- slice(companies, 1)

  inputs <- slice(inputs, 1)
  expect_visible(xctr_at_product_level(companies, inputs))
  products <- slice(products, 1)
  expect_visible(xctr_at_product_level(companies, products))
})

test_that("outputs expected columns at product level", {
  companies <- slice(companies, 1)

  inputs <- slice(inputs, 1)
  expected <- c(
    cols_at_product_level(),
    "input_activity_uuid_product_uuid",
    "input_co2_footprint"
  )
  out <- xctr_at_product_level(companies, inputs)
  expect_named(out, expected)

  products <- slice(products, 1)
  expected <- c(cols_at_product_level(), "co2_footprint")
  out <- xctr_at_product_level(companies, products)
  expect_named(out, expected)
})

test_that("unmatched products don't introduce NA's (#266)", {
  companies <- tibble(
    company_id = "x",
    activity_uuid_product_uuid = c("a", "b"),
    clustered = c("1", "2")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = c("a"),
    input_activity_uuid_product_uuid = c("m"),
    input_co2_footprint = 1,
    input_tilt_sector = "transport",
    input_unit = "metric ton*km",
    input_isic_4digit = "4575"
  )
  out <- xctr_at_product_level(companies, inputs)
  expect_false(anyNA(out$risk_category))

  products <- tibble(
    activity_uuid_product_uuid = c("a"),
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    isic_4digit = "4575"
  )
  out <- xctr_at_product_level(companies, products)
  expect_false(anyNA(out$risk_category))
})

test_that("some match yields no NA and no match yields 1 row with `NA`s (#393)", {
  companies <- tibble(
    company_id = c("a", "a", "b", "b"),
    activity_uuid_product_uuid = c("matched", paste0("unmatched", 1:3)),
    clustered = "a"
  )
  products <- tibble(
    activity_uuid_product_uuid = "matched",
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    isic_4digit = "a"
  )

  # PCTR
  out <- xctr_at_product_level(companies, products)

  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  na_cols <- setdiff(cols_at_product_level(), "companies_id")
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)

  inputs <- tibble(
    activity_uuid_product_uuid = "matched",
    input_activity_uuid_product_uuid = "matched",
    input_co2_footprint = 1,
    input_tilt_sector = "a",
    input_unit = "a",
    input_isic_4digit = "a"
  )

  # ICTR
  out <- xctr_at_product_level(companies, inputs)

  some_match <- filter(out, companies_id == "a")
  expect_false(anyNA(some_match))

  no_match <- filter(out, companies_id == "b")
  expect_equal(nrow(no_match), 1)

  na_cols <- setdiff(cols_at_product_level(), "companies_id")
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(no_match[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("with duplicated co2 throws no error (#435)", {
  duplicated <- c("a", "a")
  co2 <- tibble(
    activity_uuid_product_uuid = duplicated,
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    isic_4digit = "a"
  )
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = "a",
    clustered = "a"
  )

  expect_no_error(xctr_at_product_level(companies, co2))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
    isic_4digit = "4575"
  )

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr_at_product_level(bad, co2), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr_at_product_level(bad, co2), crucial)
})

test_that("if `co2` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
    isic_4digit = "4575"
  )

  crucial <- "co2_footprint"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr_at_product_level(companies, bad), crucial)

  crucial <- "tilt_sector"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr_at_product_level(companies, bad), crucial)

  crucial <- "unit"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr_at_product_level(companies, bad), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(co2, -all_of(crucial))
  expect_error(xctr_at_product_level(companies, bad), crucial)

  crucial <- "isic_4digit"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr_at_product_level(companies, bad), crucial)
})

test_that("handles duplicated `companies` data (#230)", {
  companies <- tibble(
    company_id = rep("a", 2),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = c("c"),
    co2_footprint = 1,
    tilt_sector = "transport",
    unit = "metric ton*km",
    isic_4digit = "4575",
  )
  expect_no_error(xctr_at_product_level(companies, co2))
})

test_that("handles duplicated `co2` data (#230)", {
  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = rep("c", 2),
    co2_footprint = 1,
    tilt_sector = "transport",
    unit = "metric ton*km",
    isic_4digit = "4575",
  )
  expect_no_error(xctr_at_product_level(companies, co2))
})

test_that("if the 'isic' column isn't a character, throws an error (#233)", {
  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = c("c"),
    co2_footprint = 1,
    tilt_sector = "transport",
    unit = "metric ton*km",
    # Not a character
    isic_4digit = 4575,
  )

  expect_error(xctr_at_product_level(companies, co2), "must be.*character")
})

test_that("a 0-row `co2` yields an error", {
  expect_error(
    xctr_at_product_level(companies[0L, ], products),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `co2` yields an error", {
  expect_error(
    xctr_at_product_level(slice(companies, 1), products[0L, ]),
    "co2.*can't have 0-row"
  )
})


test_that("a 0-row `companies` yields an error", {
  expect_error(
    xctr_at_product_level(companies[0L, ], inputs),
    "companies.*can't have 0-row"
  )
})

test_that("a 0-row `inputs` yields an error", {
  expect_error(
    xctr_at_product_level(slice(companies, 1), inputs[0L, ]),
    "co2.*can't have 0-row"
  )
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr_at_product_level(bad, inputs), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr_at_product_level(bad, inputs), crucial)
})

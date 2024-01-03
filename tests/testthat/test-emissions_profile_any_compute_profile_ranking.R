test_that("works with any 'co2-like' dataset", {
  co2 <- example_products()
  expect_no_error(emissions_profile_any_compute_profile_ranking(co2))

  co2 <- example_inputs()
  expect_no_error(emissions_profile_any_compute_profile_ranking(co2))
})

test_that("with products, adds columns `grouped_by` and `profile_ranking` to the left", {
  co2 <- example_products()

  out <- emissions_profile_any_compute_profile_ranking(co2)

  new_names <- c("grouped_by", "profile_ranking")
  expect_equal(names(out)[1:2], new_names)
})

test_that("with inputs, adds columns `grouped_by` and `profile_ranking` to the left", {
  co2 <- example_inputs()

  out <- emissions_profile_any_compute_profile_ranking(co2)

  new_names <- c("grouped_by", "profile_ranking")
  expect_equal(names(out)[1:2], new_names)
})

test_that("with one company, adds one row per benchmark per company", {
  co2 <- example_products()

  out <- emissions_profile_any_compute_profile_ranking(co2)

  number_of_benchmarks <- length(flat_benchmarks(co2))
  expect_equal(nrow(out), number_of_benchmarks)
})

test_that("with two companies, adds one row per benchmark per company", {
  co2 <- example_products(!!aka("id") := c("a", "b"))

  out <- emissions_profile_any_compute_profile_ranking(co2)

  number_of_benchmarks <- length(flat_benchmarks(co2))
  expect_equal(nrow(out), 2 * number_of_benchmarks)
})

test_that("without crucial columns errors gracefully", {
  co2 <- example_products()

  crucial <- aka("tsector")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_compute_profile_ranking(bad), crucial)

  crucial <- aka("xunit")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_compute_profile_ranking(bad), crucial)

  crucial <- aka("isic")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_compute_profile_ranking(bad), crucial)

  crucial <- aka("co2footprint")
  bad <- select(co2, -all_of(crucial))
  expect_error(emissions_profile_any_compute_profile_ranking(bad), crucial)
})

test_that("null `isic_4digit` should be excluded for ranking `isic_4digit` and `unit_isic_4digit` benchmarks", {
  co2 <- tibble(
    activity_uuid_product_uuid = c("a", "a"),
    co2_footprint = c(1, 1),
    ei_activity_name = c("a", "a"),
    ei_geography = c("a", "a"),
    isic_4digit = c(NA_character_, "'1375'"),
    tilt_sector = c("a", "a"),
    tilt_subsector = c("a", "a"),
    unit = c("a", "a")
  )
  isic <- emissions_profile_any_compute_profile_ranking(co2) |>
    filter(is.na(isic_4digit) & grouped_by == "isic_4digit")

  unit_isic <- emissions_profile_any_compute_profile_ranking(co2) |>
    filter(is.na(isic_4digit) & grouped_by == "unit_isic_4digit")

  expect_equal(isic$profile_ranking, NA_integer_)
  expect_equal(unit_isic$profile_ranking, NA_integer_)
})

test_that("null `tilt_sector` should be excluded for ranking `tilt_sector` and `unit_tilt_sector` benchmarks", {
  co2 <- tibble(
    activity_uuid_product_uuid = c("a", "a"),
    co2_footprint = c(1, 1),
    ei_activity_name = c("a", "a"),
    ei_geography = c("a", "a"),
    isic_4digit = c("'1375'", "'1375'"),
    tilt_sector = c(NA_character_, "a"),
    tilt_subsector = c("a", "a"),
    unit = c("a", "a")
  )
  tilt_sec <- emissions_profile_any_compute_profile_ranking(co2) |>
    filter(is.na(tilt_sector) & grouped_by == "tilt_sector")

  unit_tilt_sec <- emissions_profile_any_compute_profile_ranking(co2) |>
    filter(is.na(tilt_sector) & grouped_by == "unit_tilt_sector")

  expect_equal(tilt_sec$profile_ranking, NA_integer_)
  expect_equal(unit_tilt_sec$profile_ranking, NA_integer_)
})

test_that("with products, yields `NA` in `profile_ranking` where `*isic_4digit` has 2-3 digits and `grouped_by` is `(*unit_)*isic_4digit`", {
  name <- "isic_4digit"
  co2 <- example_products(!!name := c("'12'", "'123'", "'1234'"))

  out <- emissions_profile_any_compute_profile_ranking(co2)

  isic_has_2_or_3_digits_plus_quotes <- str_length(out[[name]]) %in% c(4, 5)
  relevant_benchamrks <- grepl(name, out$grouped_by)
  special_cases <- isic_has_2_or_3_digits_plus_quotes & relevant_benchamrks

  expect_true(all(is.na(filter(out, special_cases)$profile_ranking)))
  # In all other cases `profile_ranking` should not be NA
  expect_false(any(is.na(filter(out, !special_cases)$profile_ranking)))
})

test_that("with inputs, yields `NA` in `profile_ranking` where `*isic_4digit` has 2-3 digits and `grouped_by` is `(*unit_*)isic_4digit`", {
  name <- "input_isic_4digit"
  co2 <- example_inputs(!!name := c("'12'", "'123'", "'1234'"))

  out <- emissions_profile_any_compute_profile_ranking(co2)

  isic_has_2_or_3_digits_plus_quotes <- str_length(out[[name]]) %in% c(4, 5)
  relevant_benchamrks <- grepl(name, out$grouped_by)
  special_cases <- isic_has_2_or_3_digits_plus_quotes & relevant_benchamrks

  expect_true(all(is.na(filter(out, special_cases)$profile_ranking)))
  # In all other cases `profile_ranking` should not be NA
  expect_false(any(is.na(filter(out, !special_cases)$profile_ranking)))
})

test_that("with inputs, `profile_ranking` is `1` for all maximum `*co2_footprint`", {
  co2 <- example_inputs(input_co2_footprint = c(1, 2, 3, 3))

  out <- emissions_profile_any_compute_profile_ranking(co2)
  max <- filter(out, input_co2_footprint == max(input_co2_footprint))
  expect_true(all(max$profile_ranking == 1.0))

  other <- filter(out, input_co2_footprint != max(input_co2_footprint))
  expect_false(any(other$profile_ranking == 1.0))
})

test_that("with products, `profile_ranking` is `1` for all maximum `*co2_footprint`", {
  name <- "co2_footprint"
  co2 <- example_products(!!name := c(1, 2, 3, 3, 3))

  out <- emissions_profile_any_compute_profile_ranking(co2)
  max <- filter(out, .data[[name]] == max(.data[[name]]))
  expect_true(all(max$profile_ranking == 1.0))

  other <- filter(out, .data[[name]] != max(.data[[name]]))
  expect_false(any(other$profile_ranking == 1.0))
})

test_that("with inputs, `profile_ranking` is `1` for all maximum `*co2_footprint`", {
  name <- "input_co2_footprint"
  co2 <- example_inputs(!!name := c(1, 2, 3, 3, 3))

  out <- emissions_profile_any_compute_profile_ranking(co2)
  max <- filter(out, .data[[name]] == max(.data[[name]]))
  expect_true(all(max$profile_ranking == 1.0))

  other <- filter(out, .data[[name]] != max(.data[[name]]))
  expect_false(any(other$profile_ranking == 1.0))
})

test_that("input products outputs `profile_ranking` column", {
  input_co2 <- tibble(
    activity_uuid_product_uuid = "a",
    ei_activity_name = "a",
    input_activity_uuid_product_uuid = "a",
    input_co2_footprint = 1,
    input_ei_activity_name = "a",
    ei_geography = "a",
    input_reference_product_name = "a",
    input_isic_4digit = "'1375'",
    input_tilt_sector = "a",
    input_tilt_subsector = "a",
    input_unit = "a"
  )
  out <- emissions_profile_any_compute_profile_ranking(input_co2)
  expect_true(any(grepl("profile_ranking", names(out))))
})

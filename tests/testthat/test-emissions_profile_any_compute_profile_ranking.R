test_that("works with any 'co2-like' dataset", {
  co2 <- example_products()
  expect_no_error(emissions_profile_any_compute_profile_ranking(co2))

  co2 <- example_inputs()
  expect_no_error(emissions_profile_any_compute_profile_ranking(co2))
})

test_that("adds columns `grouped_by` and `profile_ranking` to the left", {
  co2 <- example_products()

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

test_that("`profile_ranking` is `1` for all maximum `*co2_footprint`", {
  pattern <- aka("co2footprint")
  co2 <- example_products(!!pattern := c(1, 2, 3, 3, 3))

  out <- emissions_profile_any_compute_profile_ranking(co2)
  max <- filter(out, .data[[pattern]] == max(.data[[pattern]]))
  expect_true(all(max$profile_ranking == 1.0))

  other <- filter(out, .data[[pattern]] != max(.data[[pattern]]))
  expect_false(any(other$profile_ranking == 1.0))
})

test_that("with inputs, `profile_ranking` is `1` for all maximum `*co2_footprint`", {
  pattern <- paste0("input_", aka("co2footprint"))
  co2 <- example_inputs(!!pattern := c(1, 2, 3, 3, 3))

  out <- emissions_profile_any_compute_profile_ranking(co2)
  max <- filter(out, .data[[pattern]] == max(.data[[pattern]]))
  expect_true(all(max$profile_ranking == 1.0))

  other <- filter(out, .data[[pattern]] != max(.data[[pattern]]))
  expect_false(any(other$profile_ranking == 1.0))
})

test_that("`profile_ranking` excludes-rows and is `NA` where `tilt_sector` is `NA` and `grouped_by` matches *tilt_sector", {
  pattern <- aka("tsector")
  exclude <- NA_character_
  co2 <- example_products(!!pattern := c("'1234'", "'1234'", exclude))
  co2[find_co2_footprint(co2)] <- c(3, 2, 1)

  out <- emissions_profile_any_compute_profile_ranking(co2)

  ranking <- unique(out$profile_ranking)
  expected <- c(rank_proportion(c(3, 2)), NA)
  expect_equal(ranking, expected)

  should_be_na <- out |>
    filter(is.na(get_column(out, pattern))) |>
    filter(grepl(pattern, grouped_by))
  expect_equal(unique(should_be_na$profile_ranking), NA_integer_)
})

test_that("with inputs, `profile_ranking` excludes-rows and is `NA` where `tilt_sector` is `NA` and `grouped_by` matches *tilt_sector", {
  pattern <- paste0("input_", aka("tsector"))
  exclude <- NA_character_
  co2 <- example_inputs(!!pattern := c("'1234'", "'1234'", exclude))
  co2[find_co2_footprint(co2)] <- c(3, 2, 1)

  out <- emissions_profile_any_compute_profile_ranking(co2)

  ranking <- unique(out$profile_ranking)
  expected <- c(rank_proportion(c(3, 2)), NA)
  expect_equal(ranking, expected)

  should_be_na <- out |>
    filter(is.na(get_column(out, pattern))) |>
    filter(grepl(pattern, grouped_by))
  expect_equal(unique(should_be_na$profile_ranking), NA_integer_)
})

test_that("`profile_ranking` excludes-rows and is `NA` where `*isic_4digit` is `NA` and `grouped_by` matches *isic_4digit", {
  pattern <- aka("isic")
  exclude <- NA_character_
  co2 <- example_products(!!pattern := c("'1234'", "'1234'", exclude))
  co2[find_co2_footprint(co2)] <- c(3, 2, 1)

  out <- emissions_profile_any_compute_profile_ranking(co2)

  ranking <- unique(out$profile_ranking)
  expected <- c(rank_proportion(c(3, 2)), NA)
  expect_equal(ranking, expected)

  excluded <- out |>
    filter(is.na(get_column(out, pattern))) |>
    filter(grepl(pattern, grouped_by))
  expect_true(all(is.na(excluded$profile_ranking)))
})

test_that("with inputs, `profile_ranking` excludes-rows and is `NA` where `*isic_4digit` is `NA` and `grouped_by` matches *isic_4digit", {
  pattern <- paste0("input_", aka("isic"))
  exclude <- NA_character_
  co2 <- example_inputs(!!pattern := c("'1234'", "'1234'", exclude))
  co2[find_co2_footprint(co2)] <- c(3, 2, 1)

  out <- emissions_profile_any_compute_profile_ranking(co2)

  ranking <- unique(out$profile_ranking)
  expected <- c(rank_proportion(c(3, 2)), NA)
  expect_equal(ranking, expected)

  excluded <- out |>
    filter(is.na(get_column(out, pattern))) |>
    filter(grepl(pattern, grouped_by))
  expect_true(all(is.na(excluded$profile_ranking)))
})

test_that("`profile_ranking` excludes-rows and is `NA` where `*isic_4digit` has 2-3 digits and `grouped_by` matches *isic_4digit", {
  pattern <- aka("isic")
  exclude <- "'12'"
  co2 <- example_products(!!pattern := c("'1234'", "'1234'", exclude))
  co2[find_co2_footprint(co2)] <- c(3, 2, 1)

  out <- emissions_profile_any_compute_profile_ranking(co2)

  ranking <- unique(out$profile_ranking)
  expected <- c(rank_proportion(c(3, 2)), NA)
  expect_equal(ranking, expected)

  excluded <- out |>
    filter(short_isic(out)) |>
    filter(grepl(pattern, grouped_by))
  expect_true(all(is.na(excluded$profile_ranking)))
})

test_that("with inputs, `profile_ranking` excludes-rows and is `NA` where `*isic_4digit` has 2-3 digits and `grouped_by` matches *isic_4digit", {
  pattern <- paste0("input_", aka("isic"))
  exclude <- "'12'"
  co2 <- example_inputs(!!pattern := c("'1234'", "'1234'", exclude))
  co2[find_co2_footprint(co2)] <- c(3, 2, 1)

  out <- emissions_profile_any_compute_profile_ranking(co2)

  ranking <- unique(out$profile_ranking)
  expected <- c(rank_proportion(c(3, 2)), NA)
  expect_equal(ranking, expected)

  excluded <- out |>
    filter(short_isic(out)) |>
    filter(grepl(pattern, grouped_by))
  expect_true(all(is.na(excluded$profile_ranking)))
})

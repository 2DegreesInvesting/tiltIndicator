test_that("with products, if data lacks crucial columns, errors gracefully", {
  data <- example_emissions_profile() |> unnest_product()

  crucial <- "grouped_by"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad), crucial)

  crucial <- "risk_category"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad), crucial)

  crucial <- find_co2_footprint(data)
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, crucial), crucial)
})

test_that("with inputs, if data lacks crucial columns, errors gracefully", {
  data <- example_emissions_profile_upstream() |> unnest_product()

  crucial <- "grouped_by"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad), crucial)

  crucial <- "risk_category"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad), crucial)

  crucial <- find_co2_footprint(data)
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, crucial), crucial)
})

test_that("with products, adds the new columns `minimum` and `maximum`", {
  data <- example_emissions_profile() |> unnest_product()

  out <- jitter_range(data)

  expect_true(hasName(out, "minimum"))
  expect_true(hasName(out, "maximum"))
})

test_that("with inputs, adds the new columns `minimum` and `maximum`", {
  data <- example_emissions_profile_upstream() |> unnest_product()

  out <- jitter_range(data)

  expect_true(hasName(out, "minimum"))
  expect_true(hasName(out, "maximum"))
})

test_that("outputs one row for each values of `grouped_by` and `risk_category`", {
  companies <- example_companies(!!aka("id") := 1:2)
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()

  out <- jitter_range(data)
  expected <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(nrow(out), expected)
})

test_that("outputs `minimum_jitter` and `maximum_jitter`", {
  companies <- example_companies(!!aka("id") := 1:2)
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()

  out <- jitter_range(data)

  expect_true(hasName(out, "minimum_jitter"))
  expect_true(hasName(out, "maximum_jitter"))
})

test_that("with products, `minimum_jitter` is lowest and `maximum_jitter` is highest", {
  companies <- read_test_csv(toy_emissions_profile_any_companies(), n_max = Inf)
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = Inf)
  data <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(!is.na(grouped_by))

  out <- jitter_range(data)

  expect_true(all(out$minimum_jitter < out$minimum))
  expect_true(all(out$maximum_jitter > out$maximum))
})

test_that("with inputs, `minimum_jitter` is lowest and `maximum_jitter` is highest", {
  companies <- read_test_csv(toy_emissions_profile_any_companies(), n_max = Inf)
  co2 <- read_test_csv(toy_emissions_profile_upstream_products(), n_max = Inf)
  data <- emissions_profile_upstream(companies, co2) |>
    unnest_product() |>
    filter(!is.na(grouped_by))

  out <- jitter_range(data)

  expect_true(all(out$minimum_jitter < out$minimum))
  expect_true(all(out$maximum_jitter > out$maximum))
})

test_that("drops missing values of `*co2_footprint` with a warning", {
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := c("a", "unmatched")
  )
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()

expect_warning(out <- jitter_range(data), class = "removing_na_from")

  expect_false(anyNA(out$grouped_by))
  expect_false(anyNA(out$risk_category))
  expect_false(anyNA(out$minimum_jitter))
  expect_false(anyNA(out$maximum_jitter))
})

test_that("with products, if data lacks crucial columns, errors gracefully", {
  data <- example_emissions_profile() |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  crucial <- "grouped_by"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by), crucial)

  crucial <- "risk_category"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by), crucial)

  crucial <- find_co2_footprint(data)
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by, crucial), crucial)
})

test_that("with inputs, if data lacks crucial columns, errors gracefully", {
  data <- example_emissions_profile_upstream() |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  crucial <- "grouped_by"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by), crucial)

  crucial <- "risk_category"
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by), crucial)

  crucial <- find_co2_footprint(data)
  bad <- select(data, -all_of(crucial))
  expect_error(jitter_range(bad, col, .by, crucial), crucial)
})

test_that("with products, adds the new columns `min` and `max`", {
  data <- example_emissions_profile() |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  out <- jitter_range(data, col, .by)

  expect_true(hasName(out, "min"))
  expect_true(hasName(out, "max"))
})

test_that("with inputs, adds the new columns `min` and `max`", {
  data <- example_emissions_profile_upstream() |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  out <- jitter_range(data, col, .by)

  expect_true(hasName(out, "min"))
  expect_true(hasName(out, "max"))
})

test_that("outputs one row for each value of `grouped_by` and `risk_category`", {
  companies <- example_companies(!!aka("id") := 1:2)
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  out <- jitter_range(data, col, .by)

  expected <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(nrow(out), expected)
})

test_that("outputs `min_jitter` and `max_jitter`", {
  companies <- example_companies(!!aka("id") := 1:2)
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  out <- jitter_range(data, col, .by)

  expect_true(hasName(out, "min_jitter"))
  expect_true(hasName(out, "max_jitter"))
})

test_that("with products, `min_jitter` is lowest and `max_jitter` is highest", {
  companies <- read_test_csv(toy_emissions_profile_any_companies(), n_max = Inf)
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = Inf)
  data <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(!is.na(grouped_by))
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  out <- jitter_range(data, col, .by)

  expect_true(all(out$min_jitter < out$min))
  expect_true(all(out$max_jitter > out$max))
})

test_that("with inputs, `min_jitter` is lowest and `max_jitter` is highest", {
  companies <- read_test_csv(toy_emissions_profile_any_companies(), n_max = Inf)
  co2 <- read_test_csv(toy_emissions_profile_upstream_products(), n_max = Inf)
  data <- emissions_profile_upstream(companies, co2) |>
    unnest_product() |>
    filter(!is.na(grouped_by))
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  out <- jitter_range(data, col, .by)

  expect_true(all(out$min_jitter < out$min))
  expect_true(all(out$max_jitter > out$max))
})

test_that("drops missing values of `*co2_footprint` with a warning", {
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := c("a", "unmatched")
  )
  co2 <- example_products()
  data <- emissions_profile(companies, co2) |> unnest_product()
  col <- find_co2_footprint(data)
  .by <- c("grouped_by", "risk_category")

  expect_warning(out <- jitter_range(data, col, .by), class = "removing_na_from")

  expect_false(anyNA(out$grouped_by))
  expect_false(anyNA(out$risk_category))
  expect_false(anyNA(out$min_jitter))
  expect_false(anyNA(out$max_jitter))
})

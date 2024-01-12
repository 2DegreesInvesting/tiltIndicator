test_that("hasn't change", {
  skip_if_toy_data_is_old()

  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- tiltToyData::toy_emissions_profile_upstream_products_ecoinvent() |>
    read_test_csv(n_max = 4)

  out <- emissions_profile_upstream(companies, inputs)

  expect_snapshot(format_robust_snapshot(unnest_product(out)))
  expect_snapshot(format_robust_snapshot(unnest_company(out)))
})

test_that("outputs expected columns at company level", {
  companies <- example_companies()
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    any_at_company_level()

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("it's arranged by `companies_id` and `grouped_by`", {
  companies <- example_companies()
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    any_at_company_level()

  expect_equal(out, arrange(out, companies_id, grouped_by))
})

test_that("is sensitive to low_threshold", {
  uid <- "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa"
  companies <- example_companies(!!aka("uid") := uid)
  inputs <- example_inputs(!!aka("uid") := uid, !!aka("ico2footprint") := 1:2)

  out1 <- emissions_profile_any_at_product_level(companies, inputs, low_threshold = .1) |>
    any_at_company_level()
  out2 <- emissions_profile_any_at_product_level(companies, inputs, low_threshold = .9) |>
    any_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  uid <- "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa"
  companies <- example_companies(!!aka("uid") := uid)
  inputs <- example_inputs(!!aka("uid") := uid, !!aka("ico2footprint") := 1:2)

  out1 <- emissions_profile_any_at_product_level(companies, inputs, high_threshold = .1) |>
    any_at_company_level()
  out2 <- emissions_profile_any_at_product_level(companies, inputs, high_threshold = .9) |>
    any_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("for a company with 3 products of varying footprints, value is 1/3 (#243)", {
  # > Adjusting the risk thresholds to 1/3 and 2/3
  low_threshold <- 1 / 3
  high_threshold <- 2 / 3
  # > If we have a company with 3 products varying in their co2_footprint
  three_products <- c("x", "y", "z")
  varying_co2_footprint <- 1:3
  # > Then the company should have values of 1/3 per risk category
  expected_value <- 1 / 3

  companies <- example_companies(!!aka("uid") := three_products)
  inputs <- example_inputs(
    !!aka("uid") := three_products,
    !!aka("ico2footprint") := varying_co2_footprint
  )

  product <- emissions_profile_any_at_product_level(companies, inputs, low_threshold, high_threshold)
  out <- any_at_company_level(product)
  expect_true(identical(unique(out$value), expected_value))
})

test_that("values sum 1", {
  companies <- example_companies()
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    any_at_company_level()

  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- example_companies(!!aka("uid") := "unmatched")
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    any_at_company_level()

  expect_equal(out$companies_id, "a")
  expect_equal(out$grouped_by, NA_character_)
  expect_equal(out$risk_category, NA_character_)
  expect_equal(out$value, NA_real_)
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- example_companies(!!aka("uid") := c("a", "unmatched"))
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    any_at_company_level()

  expect_equal(nrow(out), 18L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 18L)
  expect_false(anyNA(out))
})

test_that("accepts `company_id` with a warning (#564)", {
  companies <- example_companies() |> rename(company_id = companies_id)
  co2 <- example_inputs()

  expect_no_error(
    expect_warning(
      emissions_profile_upstream(companies, co2),
      class = "rename_id"
    )
  )
})

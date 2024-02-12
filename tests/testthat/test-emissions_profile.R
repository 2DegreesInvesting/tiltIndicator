test_that("hasn't change", {
  skip_if_toy_data_is_old()

  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- tiltToyData::toy_emissions_profile_products_ecoinvent() |>
    read_test_csv(n_max = 8)

  out <- emissions_profile(companies, inputs)
  expect_snapshot(format_robust_snapshot(unnest_product(out)))
  expect_snapshot(format_robust_snapshot(unnest_company(out)))
})

test_that("accepts `company_id` with a warning (#564)", {
  companies <- example_companies() |> rename(company_id = companies_id)
  co2 <- example_products()

  expect_no_error(
    expect_warning(
      emissions_profile(companies, co2),
      class = "rename_id"
    )
  )
})

test_that("in each benchmark, `profile_ranking` increases with `*co2_footprint`", {
  companies <- example_companies()
  co2 <- example_products(co2_footprint = -1:1)

  out <- unnest_product(emissions_profile(companies, co2))

  in_all_benchmarks_profile_ranking_increases_with_co2_footprint <- out |>
    group_by(grouped_by) |>
    mutate(both_increasing = both_increasing(profile_ranking, co2_footprint)) |>
    pull(both_increasing) |>
    all()

  expect_true(in_all_benchmarks_profile_ranking_increases_with_co2_footprint)
})

test_that("at product level, `NA` in a benchmark column yields `NA` in the corresponding `risk_category` and `profile_ranking` (#638)", {
  companies <- example_companies()

  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := NA)

  out <- emissions_profile(companies, co2)
  product <- unnest_product(out)

  corresponding <- filter(product, grouped_by == benchmark)
  expect_true(is.na(corresponding$risk_category))
  expect_true(is.na(corresponding$profile_ranking))
})

test_that("at product level, with no match preserves unmatched products, filling with `NA`s (#657)", {
  companies <- example_companies(!!aka("uid") := c("unmatched"))

  products <- example_products()
  out <- emissions_profile(companies, products) |> unnest_product()

  expect_equal(nrow(out), 1)
  expect_equal(out[[aka("uid")]], "unmatched")

  na_cols <- setdiff(cols_na_at_product_level(), aka("uid"))
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(out[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("at product level, with some match preserves unmatched products, filling with `NA`s (#657)", {
  companies <- example_companies(!!aka("uid") := c("a", "unmatched"))

  co2 <- example_products()
  out <- emissions_profile(companies, co2) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("uid")]])

  unmatched_row <- 1
  expect_equal(nrow(out), length(flat_benchmarks(co2)) + unmatched_row)

  unmatched <- filter(out, out[[aka("uid")]] == "unmatched")
  na_cols <- setdiff(cols_na_at_product_level(), aka("uid"))
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(unmatched[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("at company level, `NA` in a benchmark column yields `NA` in the corresponding `risk_category` (#638)", {
  companies <- example_companies()

  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := NA)

  out <- emissions_profile(companies, co2)
  company <- unnest_company(out)

  expect_true(any(is.na(company$risk_category)))
  expect_true(any(grepl(benchmark, company$grouped_by)))
})

test_that("at company level, `NA` in a benchmark column yields the expected `value`s (#638)", {
  companies <- example_companies()
  co2 <- example_products(tilt_sector = c(1.0, NA))

  company <- emissions_profile(companies, co2) |> unnest_company()
  out <- company |> filter(grepl("tilt_sector", grouped_by))
  expect_snapshot(out)
})

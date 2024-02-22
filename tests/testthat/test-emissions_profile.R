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

test_that("at product level, `NA` in a benchmark yields `NA` in `risk_category` and `profile_ranking` (#638)", {
  companies <- example_companies()

  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := NA)
  out <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))

  benchmark <- "tilt_sector"
  co2 <- example_products("{ benchmark }" := NA)
  out <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))

  benchmark <- "unit"
  co2 <- example_products("{ benchmark }" := NA)
  out <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))
})

test_that("at product level, `NA` in a benchmark yields `NA`s only in the corresponding product (#638)", {
  companies <- example_companies(
    !!aka("id") := c("a", "a"),
    !!aka("uid") := c("a", "b"),
    !!aka("cluster") := c("a", "b"),
  )

  benchmark <- "isic_4digit"
  co2 <- example_products(
    !!aka("uid") := c("a", "b"),
    "{ benchmark }" := c("'1234'", NA)
  )

  out <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)

  expect_false(is.na(filter(out, clustered == "a")$risk_category))
  expect_true(is.na(filter(out, clustered == "b")$risk_category))

  benchmark <- "tilt_sector"
  co2 <- example_products(
    !!aka("uid") := c("a", "b"),
    "{ benchmark }" := c("a", NA)
  )

  out <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)

  expect_false(is.na(filter(out, clustered == "a")$risk_category))
  expect_true(is.na(filter(out, clustered == "b")$risk_category))

  benchmark <- "unit"
  co2 <- example_products(
    !!aka("uid") := c("a", "b"),
    "{ benchmark }" := c("a", NA)
  )

  out <- emissions_profile(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)

  expect_false(is.na(filter(out, clustered == "a")$risk_category))
  expect_true(is.na(filter(out, clustered == "b")$risk_category))
})


test_that("at company level, with two matched products and `NA` in one benchmark yields `value` of `0.5` where the corresponding `risk_category` is `NA`, `0.5` in one other `risk_category`, and `0` elsewhere (#638)", {
  companies <- example_companies(
    !!aka("id") := c("a", "a"),
    !!aka("uid") := c("a", "b"),
    !!aka("cluster") := c("a", "b"),
  )

  benchmark <- "isic_4digit"
  co2 <- example_products(
    !!aka("uid") := c("a", "b"),
    "{ benchmark }" := c("'1234'", NA)
  )

  out <- emissions_profile(companies, co2) |>
    unnest_company()
  # expect `0.5` where `risk_category` is `NA`
  out |>
    filter(grepl(benchmark, grouped_by)) |>
    filter(is.na(risk_category)) |>
    distinct(value) |>
    pull() |>
    expect_equal(0.5)
  # expect `0.5` in one other `risk_category` and `0` elsewhere
  out |>
    filter(grepl(benchmark, grouped_by)) |>
    filter(!is.na(risk_category)) |>
    distinct(value) |>
    pull() |>
    sort() |>
    expect_equal(c(0, 0.5))
})

test_that("at company level, `NA` in the benchmark of 1/3 products yields a `value` of `1/3` where the corresponding `risk_category` is `NA` (#638)", {
  companies <- example_companies(
    !!aka("id") := c("a", "a", "a"),
    !!aka("uid") := c("a", "b", "c"),
    !!aka("cluster") := c("a", "b", "c"),
  )

  benchmark <- "isic_4digit"
  co2 <- example_products(
    !!aka("uid") := c("a", "b", "c"),
    "{ benchmark }" := c("'1234'", NA, "'1234'")
  )

  out <- emissions_profile(companies, co2) |>
    unnest_company()
  # expect `1/3` where `risk_category` is `NA`
  out |>
    filter(grepl(benchmark, grouped_by)) |>
    filter(is.na(risk_category)) |>
    distinct(value) |>
    pull() |>
    expect_equal(1 / 3)
})

test_that("at company level, `NA` in a benchmark yields `NA` in `risk_category` and not in `value` (#638)", {
  companies <- example_companies()
  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := NA)

  company <- emissions_profile(companies, co2) |> unnest_company()

  corresponding <- filter(company, grepl(benchmark, grouped_by))
  corresponding <- split(corresponding, corresponding$grouped_by)
  risk_category <- unlist(unique(map(corresponding, "risk_category")))
  expect_equal(risk_category, c("high", "medium", "low", NA))
  value <- unlist(unique(map(corresponding, "value")))
  expect_false(anyNA(value))
})

test_that("at company level, `NA` in a benchmark yields `value = 1` where `grouped_by` matches the benchmark and `risk_category` is `NA` (#638)", {
  companies <- example_companies()

  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := c(NA))
  out <- emissions_profile(companies, co2) |> unnest_company()
  # For each benchmark `value` adds to 1
  out |>
    filter(grepl(benchmark, grouped_by)) |>
    summarize(sum = sum(value), .by = grouped_by) |>
    distinct(sum) |>
    pull(sum) |>
    expect_equal(1)
  # `value = 1` where `grouped_by` matches the benchmark and `risk_category` is `NA`
  out |>
    filter(is.na(risk_category)) |>
    filter(grepl(benchmark, grouped_by)) |>
    summarize(sum = sum(value), .by = grouped_by) |>
    distinct(sum) |>
    pull(sum) |>
    expect_equal(1)

  benchmark <- "tilt_sector"
  co2 <- example_products("{ benchmark }" := c(NA))
  out <- emissions_profile(companies, co2) |> unnest_company()
  # For each benchmark `value` adds to 1
  out |>
    filter(grepl(benchmark, grouped_by)) |>
    summarize(sum = sum(value), .by = grouped_by) |>
    distinct(sum) |>
    pull(sum) |>
    expect_equal(1)
  # `value = 1` where `grouped_by` matches the benchmark and `risk_category` is `NA`
  out |>
    filter(is.na(risk_category)) |>
    filter(grepl(benchmark, grouped_by)) |>
    summarize(sum = sum(value), .by = grouped_by) |>
    distinct(sum) |>
    pull(sum) |>
    expect_equal(1)

  benchmark <- "unit"
  co2 <- example_products("{ benchmark }" := c(NA))
  out <- emissions_profile(companies, co2) |> unnest_company()
  # For each benchmark `value` adds to 1
  out |>
    filter(grepl(benchmark, grouped_by)) |>
    summarize(sum = sum(value), .by = grouped_by) |>
    distinct(sum) |>
    pull(sum) |>
    expect_equal(1)
  # `value = 1` where `grouped_by` matches the benchmark and `risk_category` is `NA`
  out |>
    filter(is.na(risk_category)) |>
    filter(grepl(benchmark, grouped_by)) |>
    summarize(sum = sum(value), .by = grouped_by) |>
    distinct(sum) |>
    pull(sum) |>
    expect_equal(1)
})

test_that("at company level, `risk_category` always has the value `NA` (#638)", {
  companies <- example_companies()

  co2 <- example_products()
  out <- emissions_profile(companies, co2) |> unnest_company()
  out |>
    distinct(risk_category) |>
    anyNA() |>
    expect_true()

  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := c("a", NA))
  out <- emissions_profile(companies, co2) |> unnest_company()

  number_of_na_per_benchmark <- out |>
    summarize(n = sum(is.na(risk_category)), .by = grouped_by) |>
    pull(n) |>
    unique()
  expect_equal(number_of_na_per_benchmark, 1)
})

test_that("the order of companies is preserved", {
  expected_order <- c("a", "c", "b")

  companies <- example_companies(!!aka("id") := expected_order)
  co2 <- example_products()

  both <- emissions_profile(companies, co2)

  out <- both |> unnest_product()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
  out <- both |> unnest_company()
  expect_equal(pull(distinct(out, companies_id)), expected_order)

  benchmark <- "isic_4digit"
  co2 <- example_products("{ benchmark }" := c("a", NA))

  both <- emissions_profile(companies, co2)

  out <- both |> unnest_product()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
  out <- both |> unnest_company()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
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

test_that("at company level, 1 matched product yields `value = 1` in 1 `risk_category` (#657)", {
  one_matched <- c("a")
  companies <- example_companies(!!aka("uid") := one_matched)
  matched <- one_matched
  co2 <- example_products(
    !!aka("uid") := one_matched
  )

  out <- emissions_profile(companies, co2) |>
    unnest_company() |>
    distinct(risk_category, value) |>
    pull(value)

  expect_equal(sort(out), c(0, 0, 0, 1))
})

test_that("at company level, 2 matched products yield `value = 1` in 1 `risk_category` (#657)", {
  two_matched <- c("a", "b")
  companies <- example_companies(!!aka("uid") := two_matched)
  matched <- two_matched
  co2 <- example_products(
    !!aka("uid") := matched
  )

  out <- emissions_profile(companies, co2) |>
    unnest_company() |>
    distinct(risk_category, value) |>
    pull(value)

  expect_equal(sort(out), c(0, 0, 0, 1))
})

test_that("at company level, 1 matched and 1 unmatched products yield `value = 1/2` where `risk_category = NA` and in 1 other `risk_category` (#657)", {
  one_matched_one_unmatched <- c("a", "unmatched")
  companies <- example_companies(!!aka("uid") := one_matched_one_unmatched)
  matched <- one_matched_one_unmatched[1]
  co2 <- example_products(!!aka("uid") := matched)

  out <- emissions_profile(companies, co2) |>
    unnest_company() |>
    distinct(risk_category, value)

  na <- pull(filter(out, is.na(risk_category)), value)
  expect_equal(na, 1 / 2)
  other <- pull(filter(out, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 1 / 2))
})

test_that("at company level, 2 matched and 1 unmatched products yield `value = 1/3` where `risk_category = NA` and `2/3` in 1 other `risk_category` (#657)", {
  two_matched_and_one_unmatched <- c("a", "b", "unmatched")
  companies <- example_companies(!!aka("uid") := two_matched_and_one_unmatched)
  matched <- two_matched_and_one_unmatched[1:2]
  co2 <- example_products(!!aka("uid") := matched)

  out <- emissions_profile(companies, co2) |>
    unnest_company() |>
    distinct(risk_category, value)

  na <- pull(filter(out, is.na(risk_category)), value)
  expect_equal(na, 1 / 3)
  other <- pull(filter(out, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 2 / 3))
})

test_that("at company level, 1 matched product, one missing benchmark, and one unmatched product yield `value = 2/3` where `risk_category = NA` and `1/3` in 1 other `risk_category` (#657)", {
  missing_benchmark <- "b"
  two_matched_and_one_unmatched <- c("a", missing_benchmark, "unmatched")
  companies <- example_companies(!!aka("uid") := two_matched_and_one_unmatched)
  matched <- two_matched_and_one_unmatched[1:2]
  co2 <- example_products(
    !!aka("uid") := matched,
    !!aka("isic") := c("'1234'", NA)
  )

  isic <- emissions_profile(companies, co2) |>
    unnest_company() |>
    filter(grouped_by == aka("isic"))

  na <- pull(filter(isic, is.na(risk_category)), value)
  expect_equal(na, 2 / 3)
  other <- pull(filter(isic, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 1 / 3))

  isic <- emissions_profile(companies, co2) |>
    unnest_company() |>
    filter(grepl(aka("isic"), grouped_by)) |>
    distinct(risk_category, value)

  na <- pull(filter(isic, is.na(risk_category)), value)
  expect_equal(na, 2 / 3)
  other <- pull(filter(isic, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 1 / 3))
})

test_that("at company level, unmatched companies are preserved", {
  co2 <- example_products()

  # Two companies, one match
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := c("a", "unmatched")
  )
  company <- emissions_profile(companies, co2) |> unnest_company()
  expect_equal(unique(company$companies_id), companies[[aka("id")]])

  # Two companies, no match
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := "unmatched"
  )
  company <- emissions_profile(companies, co2) |> unnest_company()
  expect_equal(unique(company$companies_id), companies[[aka("id")]])

  # One company, no match
  companies <- example_companies(!!aka("uid") := "unmatched")
  company <- emissions_profile(companies, co2) |> unnest_company()
  expect_equal(company$companies_id, companies[[aka("id")]])
})

test_that("at company level, unmatched companies have a single row", {
  co2 <- example_products()

  # Two companies, one match
  unmatched <- "b"
  companies <- example_companies(
    !!aka("id") := c("a", unmatched),
    !!aka("uid") := c("a", "unmatched")
  )
  company <- emissions_profile(companies, co2) |> unnest_company()
  n_unmatched <- sum(company[[aka("id")]] == unmatched)
  expect_equal(n_unmatched, 1L)

  # Two companies, no match
  unmatched <- c("a", "b")
  companies <- example_companies(
    !!aka("id") := unmatched,
    !!aka("uid") := "unmatched"
  )
  company <- emissions_profile(companies, co2) |> unnest_company()
  n_unmatched <- sum(company[[aka("id")]] == unmatched[[1]])
  expect_equal(n_unmatched, 1L)
  n_unmatched <- sum(company[[aka("id")]] == unmatched[[2]])
  expect_equal(n_unmatched, 1L)

  # One company, no match
  companies <- example_companies(!!aka("uid") := "unmatched")
  company <- emissions_profile(companies, co2) |> unnest_company()
  n_unmatched <- sum(company[[aka("id")]] == "a")
  expect_equal(n_unmatched, 1L)
})

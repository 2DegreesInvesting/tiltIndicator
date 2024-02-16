test_that("hasn't change", {
  skip_if_toy_data_is_old()

  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- tiltToyData::toy_emissions_profile_upstream_products_ecoinvent() |>
    read_test_csv(n_max = Inf)

  out <- emissions_profile_upstream(companies, inputs)

  expect_snapshot(format_robust_snapshot(unnest_product(out)))
  expect_snapshot(format_robust_snapshot(unnest_company(out)))
})

test_that("outputs expected columns at company level", {
  companies <- example_companies()
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    epa_at_company_level()

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("it's arranged by `companies_id` and `grouped_by`", {
  companies <- example_companies()
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    epa_at_company_level()

  expect_equal(out, arrange(out, companies_id, grouped_by))
})

test_that("is sensitive to low_threshold", {
  uid <- "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa"
  companies <- example_companies(!!aka("uid") := uid)
  inputs <- example_inputs(!!aka("uid") := uid, !!aka("ico2footprint") := 1:2)

  out1 <- emissions_profile_any_at_product_level(companies, inputs, low_threshold = .1) |>
    epa_at_company_level()
  out2 <- emissions_profile_any_at_product_level(companies, inputs, low_threshold = .9) |>
    epa_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  uid <- "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa"
  companies <- example_companies(!!aka("uid") := uid)
  inputs <- example_inputs(!!aka("uid") := uid, !!aka("ico2footprint") := 1:2)

  out1 <- emissions_profile_any_at_product_level(companies, inputs, high_threshold = .1) |>
    epa_at_company_level()
  out2 <- emissions_profile_any_at_product_level(companies, inputs, high_threshold = .9) |>
    epa_at_company_level()
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
  out <- epa_at_company_level(product)
  expect_true(identical(unique(out$value), expected_value))
})

test_that("values sum 1", {
  companies <- example_companies()
  inputs <- example_inputs()

  out <- emissions_profile_any_at_product_level(companies, inputs) |>
    epa_at_company_level()

  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- example_companies(!!aka("uid") := "unmatched")
  inputs <- example_inputs()

  out <- emissions_profile_upstream(companies, inputs) |>
    unnest_company()

  expect_equal(out$companies_id, "a")
  expect_equal(out$grouped_by, NA_character_)
  expect_equal(out$risk_category, NA_character_)
  expect_equal(out$value, NA_real_)
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- example_companies(!!aka("uid") := c("a", "unmatched"))
  inputs <- example_inputs()

  out <- emissions_profile_upstream(companies, inputs) |> unnest_company()

  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(nrow(out), n)
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

test_that("in each benchmark, `profile_ranking` increases with `*co2_footprint`", {
  companies <- example_companies()
  co2 <- example_inputs(input_co2_footprint = -1:1)

  out <- unnest_product(emissions_profile_upstream(companies, co2))

  in_all_benchmarks_profile_ranking_increases_with_co2_footprint <- out |>
    group_by(grouped_by) |>
    mutate(both_increasing = both_increasing(profile_ranking, input_co2_footprint)) |>
    pull(both_increasing) |>
    all()

  expect_true(in_all_benchmarks_profile_ranking_increases_with_co2_footprint)
})

test_that("at product level, `NA` in a benchmark yields `NA` in `risk_category` and `profile_ranking` (#638)", {
  companies <- example_companies()

  benchmark <- "input_isic_4digit"
  co2 <- example_inputs("{ benchmark }" := NA)

  out <- emissions_profile_upstream(companies, co2)
  product <- unnest_product(out)

  corresponding <- filter(product, grouped_by == benchmark)
  expect_true(is.na(corresponding$risk_category))
  expect_true(is.na(corresponding$profile_ranking))
})

test_that("at product level, `NA` in a benchmark yields `NA`s only in the corresponding product (#638)", {
  companies <- example_companies(
    !!aka("id")      := c("a", "a"),
    !!aka("uid")     := c("a", "b"),
    !!aka("cluster") := c("a", "b"),
  )

  benchmark <- "input_isic_4digit"
  co2 <- example_inputs(
    !!aka("uid")  := c("a", "b"),
    "{ benchmark }" := c("'1234'", NA)
  )

  out <- emissions_profile_upstream(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)

  expect_false(is.na(filter(out, clustered == "a")$risk_category))
  expect_true(is.na(filter(out, clustered == "b")$risk_category))

  benchmark <- "input_tilt_sector"
  co2 <- example_inputs(
    !!aka("uid")  := c("a", "b"),
    "{ benchmark }" := c("a", NA)
  )

  out <- emissions_profile_upstream(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)

  expect_false(is.na(filter(out, clustered == "a")$risk_category))
  expect_true(is.na(filter(out, clustered == "b")$risk_category))

  benchmark <- "input_unit"
  co2 <- example_inputs(
    !!aka("uid")  := c("a", "b"),
    "{ benchmark }" := c("a", NA)
  )

  out <- emissions_profile_upstream(companies, co2) |>
    unnest_product() |>
    filter(grouped_by == benchmark)

  expect_false(is.na(filter(out, clustered == "a")$risk_category))
  expect_true(is.na(filter(out, clustered == "b")$risk_category))
})

test_that("at company level, with two matched products and `NA` in one benchmark yields `value` of `0.5` where the corresponding `risk_category` is `NA`, `0.5` in one other `risk_category`, and `0` elsewhere (#638)", {
  companies <- example_companies(
    !!aka("id")      := c("a", "a"),
    !!aka("uid")     := c("a", "b"),
    !!aka("cluster") := c("a", "b"),
  )

  benchmark <- "input_isic_4digit"
  co2 <- example_inputs(
    !!aka("uid")  := c("a", "b"),
    "{ benchmark }" := c("'1234'", NA)
  )

  out <- emissions_profile_upstream(companies, co2) |>
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

test_that("at company level, `NA` in a benchmark yields `NA` in `risk_category` and not in `value` (#638)", {
  companies <- example_companies()
  benchmark <- "input_isic_4digit"
  co2 <- example_inputs("{ benchmark }" := NA)

  company <- emissions_profile_upstream(companies, co2) |> unnest_company()

  corresponding <- filter(company, grepl(benchmark, grouped_by))
  corresponding <- split(corresponding, corresponding$grouped_by)
  risk_category <- unlist(unique(map(corresponding, "risk_category")))
  expect_equal(risk_category, c("high", "medium", "low", NA))
  value <- unlist(unique(map(corresponding, "value")))
  expect_false(anyNA(value))
})

test_that("at company level, `NA` in a benchmark yields `value = 1` where `grouped_by` matches the benchmark and `risk_category` is `NA` (#638)", {
  companies <- example_companies()

  benchmark <- "input_isic_4digit"
  co2 <- example_inputs("{ benchmark }" := c(NA))
  out <- emissions_profile_upstream(companies, co2) |> unnest_company()
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

  benchmark <- "input_tilt_sector"
  co2 <- example_inputs("{ benchmark }" := c(NA))
  out <- emissions_profile_upstream(companies, co2) |> unnest_company()
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

  benchmark <- "input_unit"
  co2 <- example_inputs("{ benchmark }" := c(NA))
  out <- emissions_profile_upstream(companies, co2) |> unnest_company()
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

  co2 <- example_inputs()
  out <- emissions_profile_upstream(companies, co2) |> unnest_company()
  out |>
    distinct(risk_category) |>
    anyNA() |>
    expect_true()

  benchmark <- "input_isic_4digit"
  co2 <- example_inputs("{ benchmark }" := c("a", NA))
  out <- emissions_profile_upstream(companies, co2) |> unnest_company()

  number_of_na_per_benchmark <- out |>
    summarize(n = sum(is.na(risk_category)), .by = grouped_by) |>
    pull(n) |>
    unique()
  expect_equal(number_of_na_per_benchmark, 1)
})

test_that("the order of companies is preserved", {
  expected_order <- c("a", "c", "b")

  companies <- example_companies(!!aka("id") := expected_order)
  co2 <- example_inputs()

  both <- emissions_profile_upstream(companies, co2)

  out <- both |> unnest_product()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
  out <- both |> unnest_company()
  expect_equal(pull(distinct(out, companies_id)), expected_order)

  benchmark <- "input_isic_4digit"
  co2 <- example_inputs("{ benchmark }" := c("a", NA))

  both <- emissions_profile_upstream(companies, co2)

  out <- both |> unnest_product()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
  out <- both |> unnest_company()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
})

test_that("at product level, with no match preserves unmatched products, filling with `NA`s (#657)", {
  companies <- example_companies(!!aka("uid") := c("unmatched"))

  co2 <- example_inputs()
  out <- emissions_profile_upstream(companies, co2) |> unnest_product()

  expect_equal(nrow(out), 1)
  expect_equal(out[[aka("uid")]], "unmatched")

  na_cols <- setdiff(cols_na_at_product_level(), aka("uid"))
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(out[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("at product level, with some match preserves unmatched products, filling with `NA`s (#657)", {
  companies <- example_companies(!!aka("uid") := c("a", "unmatched"))

  co2 <- example_inputs()
  out <- emissions_profile_upstream(companies, co2) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("uid")]])

  unmatched_row <- 1
  expect_equal(nrow(out), length(flat_benchmarks(co2)) + unmatched_row)

  unmatched <- filter(out, out[[aka("uid")]] == "unmatched")
  na_cols <- setdiff(cols_na_at_product_level(), aka("uid"))
  all_na_cols_are_na <- all(map_lgl(na_cols, ~ is.na(unmatched[[.x]])))
  expect_true(all_na_cols_are_na)
})

test_that("at company level, unmatched companies are preserved", {
  co2 <- example_inputs()

  # Two companies, one match
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := c("a", "unmatched")
  )
  company <- emissions_profile_upstream(companies, co2) |> unnest_company()
  expect_equal(unique(company$companies_id), companies[[aka("id")]])

  # Two companies, no match
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := "unmatched"
  )
  company <- emissions_profile_upstream(companies, co2) |> unnest_company()
  expect_equal(unique(company$companies_id), companies[[aka("id")]])

  # One company, no match
  companies <- example_companies(!!aka("uid") := "unmatched")
  company <- emissions_profile_upstream(companies, co2) |> unnest_company()
  expect_equal(company$companies_id, companies[[aka("id")]])
})

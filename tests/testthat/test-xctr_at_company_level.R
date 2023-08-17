test_that("hasn't change", {
  out <- xctr_product(companies, products) |>
    xctr_company() |>
    dplyr::arrange(companies_id) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("outputs expected columns at company level", {
  companies <- slice(companies, 1)
  co2 <- slice(products, 1)

  product <- xctr_product(companies, co2)
  out <- xctr_company(product)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("is sensitive to low_threshold", {
  companies <- slice(companies, 1:2)
  co2 <- slice(products, 1:2)
  out1 <- xctr_product(companies, co2, low_threshold = .1) |>
    xctr_company()
  out2 <- xctr_product(companies, co2, low_threshold = .9) |>
    xctr_company()
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(companies, 1:2)
  co2 <- slice(products, 1:2)
  out1 <- xctr_product(companies, co2, high_threshold = .1) |>
    xctr_company()
  out2 <- xctr_product(companies, co2, high_threshold = .9) |>
    xctr_company()
  expect_false(identical(out1, out2))
})

test_that("no longer drops companies depending on co2 data (#122)", {
  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- slice(products, 1:5)
  product <- xctr_product(companies, co2)
  out <- xctr_company(product)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- slice(products, 1:4)
  product <- xctr_product(companies, co2)
  out <- xctr_company(product)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- slice(products, 1:10)
  product <- xctr_product(companies, co2)
  out <- xctr_company(product)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- slice(products, 1:9)
  product <- xctr_product(companies, co2)
  out <- xctr_company(product)
  expect_equal(length(unique(out$companies_id)), 2L)
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

  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = three_products,
  )
  co2 <- tibble(
    activity_uuid_product_uuid = three_products,
    co2_footprint = varying_co2_footprint,
    tilt_sector = "transport",
    unit = "metric ton*km",
    isic_4digit = "4575",
  )

  out <- xctr_product(companies, co2, low_threshold, high_threshold) |>
    xctr_company()
  expect_true(identical(unique(out$value), expected_value))
})

test_that("for each company & benchmark, each risk category is unique (#285)", {
  # styler: off
  companies <- tibble::tribble(
                            ~company_id,          ~clustered,                                                 ~activity_uuid_product_uuid, ~unit,
    "-fred-sl_00000005407085-741049001",      "fish, frozen", "0fe31e67-346a-504c-a03d-64f85ccc2a64_a459eea1-4e62-4daf-9135-1aea9805aa90",  "kg",
    "-fred-sl_00000005407085-741049001", "fish, deep-frozen", "26104519-4d49-5d85-bc74-e8e03d1a7914_cdbf0bef-39f7-46c8-87a2-3f9f679b5bb7",  "kg"
  )
  co2 <- tibble::tribble(
                                                    ~activity_uuid_product_uuid,  ~unit,            ~tilt_sector, ~isic_4digit,   ~co2_footprint,
    # In companies
    "0fe31e67-346a-504c-a03d-64f85ccc2a64_a459eea1-4e62-4daf-9135-1aea9805aa90",   "kg",                      NA,       "0311", 2.83222756713596,
    "26104519-4d49-5d85-bc74-e8e03d1a7914_cdbf0bef-39f7-46c8-87a2-3f9f679b5bb7",   "kg",                      NA,       "0311",  2.1156617059259,
    # Not in companies
    "0faa7ecb-fef2-5117-8993-387c1898ffc8_c33b5236-001e-49b5-aa3d-810c0214f9ce",   "kg",      "Steel and Metals",       "2410", 4.94911765272901,
    "9b414d69-2bd2-5b44-bd5d-56672896aac5_0f2ea065-f26c-4356-a261-39ef2799aea4", "unit", "Construction Industry",       "4322", 11266.1570789735,
    "74c3b4f6-dc3d-5e13-badf-70b4c3a965d3_54186f39-acc2-4c84-95e7-fbb067bde4cd",   "ha",                      NA,       "0161", 51.6463779571345,
    "72651603-406a-545d-a03d-1d1caf656efb_765e7edf-19bc-4110-bb7c-32df8d749c54",   "m3", "Non-metallic Minerals",       "2395", 424.269497499198
  )
  # styler: on

  product <- xctr_product(companies, co2)
  out <- xctr_company(product)

  bad <- out |>
    count(grouped_by, risk_category) |>
    filter(n > 1) |>
    nrow()
  expect_equal(bad, 0)
})

test_that("values sum 1", {
  companies <- tibble(
    activity_uuid_product_uuid = "a",
    company_id = "a",
    clustered = "a"
  )
  co2 <- tibble(
    activity_uuid_product_uuid = "a",
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    isic_4digit = "a"
  )

  product <- xctr_product(companies, co2)
  out <- xctr_company(product)

  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- tibble(
    activity_uuid_product_uuid = "unmatched",
    company_id = "a",
    clustered = "a"
  )
  co2 <- tibble(
    activity_uuid_product_uuid = "a",
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    isic_4digit = "a"
  )

  product <- xctr_product(companies, co2)
  out <- xctr_company(product)

  expect_equal(out$companies_id, "a")
  expect_equal(out$grouped_by, NA_character_)
  expect_equal(out$risk_category, NA_character_)
  expect_equal(out$value, NA_real_)
})

test_that("no match preserves companies", {
  co2 <- tibble(
    activity_uuid_product_uuid = "a",
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    isic_4digit = "a"
  )

  companies <- tibble(
    activity_uuid_product_uuid = c("a", "unmatched"),
    company_id = c("a", "b"),
    clustered = "a"
  )
  product <- xctr_product(companies, co2)
  expect_equal(companies$company_id, unique(product$companies_id))
  company <- xctr_company(product)
  expect_equal(companies$company_id, unique(company$companies_id))

  companies <- tibble(
    activity_uuid_product_uuid = "unmatched",
    company_id = "a",
    clustered = "a"
  )
  product <- xctr_product(companies, co2)
  expect_equal(companies$company_id, product$companies_id)
  company <- xctr_company(product)
  expect_equal(companies$company_id, company$companies_id)

  companies <- tibble(
    activity_uuid_product_uuid = c("unmatched", "unmatched"),
    company_id = c("a", "b"),
    clustered = "a"
  )
  product <- xctr_product(companies, co2)
  expect_equal(companies$company_id, unique(product$companies_id))
  company <- xctr_company(product)
  expect_equal(companies$company_id, unique(company$companies_id))
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- tibble(
    activity_uuid_product_uuid = c("a", "unmatched"),
    company_id = "a",
    clustered = "a"
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "a",
    unit = "a",
    activity_uuid_product_uuid = "a",
    isic_4digit = "a"
  )

  product <- xctr_product(companies, co2)
  out <- xctr_company(product)

  expect_equal(nrow(out), 18L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 18L)
  expect_false(anyNA(out))
})

test_that("in a user-environment throws a deprecation warning", {
  local_envvar(list("TESTTHAT" = ""))
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  out <- suppressWarnings(xctr_product(companies, inputs))
  expect_warning(xctr_company(out), "deprecated")
})

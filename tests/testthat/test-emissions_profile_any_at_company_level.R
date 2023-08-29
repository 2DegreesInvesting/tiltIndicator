test_that("hasn't change", {
  out <- emissions_profile_any_at_product_level(companies, products) |>
    any_at_company_level() |>
    dplyr::arrange(companies_id) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("outputs expected columns at company level", {
  companies <- example_companies()
  co2 <- example_products()

  product <- emissions_profile_any_at_product_level(companies, co2)
  out <- any_at_company_level(product)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("is sensitive to low_threshold", {
  uid <- c(
    "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa",
    "be06d25c-73dc-55fb-965b-0f300453e380_98b48ff2-2200-4b08-9dec-9c7c0e3585bc"
  )
  companies <- example_companies(!!aka("uid") := uid)

  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = 2)
  out1 <- emissions_profile_any_at_product_level(companies, co2, low_threshold = .1) |>
    any_at_company_level()
  out2 <- emissions_profile_any_at_product_level(companies, co2, low_threshold = .9) |>
    any_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- read_test_csv(toy_emissions_profile_any_companies(), n_max = 2)
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = 2)
  out1 <- emissions_profile_any_at_product_level(companies, co2, high_threshold = .1) |>
    any_at_company_level()
  out2 <- emissions_profile_any_at_product_level(companies, co2, high_threshold = .9) |>
    any_at_company_level()
  expect_false(identical(out1, out2))
})

test_that("no longer drops companies depending on co2 data (#122)", {
  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = 5)
  product <- emissions_profile_any_at_product_level(companies, co2)
  out <- any_at_company_level(product)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = 4)
  product <- emissions_profile_any_at_product_level(companies, co2)
  out <- any_at_company_level(product)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = 10)
  product <- emissions_profile_any_at_product_level(companies, co2)
  out <- any_at_company_level(product)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- read_test_csv(toy_emissions_profile_products(), n_max = 9)
  product <- emissions_profile_any_at_product_level(companies, co2)
  out <- any_at_company_level(product)
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

  companies <- example_companies(!!aka("uid") := three_products)
  products <- example_products(
    !!aka("uid") := three_products,
    !!aka("co2footprint") := varying_co2_footprint
  )

  out <- emissions_profile_any_at_product_level(companies, products, low_threshold, high_threshold) |>
    any_at_company_level()
  expect_true(identical(unique(out$value), expected_value))
})

test_that("for each company & benchmark, each risk category is unique (#285)", {
  # styler: off
  companies <- tribble(
                            ~company_id,          ~clustered,                                                 ~activity_uuid_product_uuid, ~unit,
    "-fred-sl_00000005407085-741049001",      "fish, frozen", "0fe31e67-346a-504c-a03d-64f85ccc2a64_a459eea1-4e62-4daf-9135-1aea9805aa90",  "kg",
    "-fred-sl_00000005407085-741049001", "fish, deep-frozen", "26104519-4d49-5d85-bc74-e8e03d1a7914_cdbf0bef-39f7-46c8-87a2-3f9f679b5bb7",  "kg"
  )
  co2 <- tribble(
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

  product <- emissions_profile_any_at_product_level(companies, co2)
  out <- any_at_company_level(product)

  bad <- out |>
    count(grouped_by, risk_category) |>
    filter(n > 1) |>
    nrow()
  expect_equal(bad, 0)
})

test_that("values sum 1", {
  companies <- example_companies()
  products <- example_products()

  product <- emissions_profile_any_at_product_level(companies, products)
  out <- any_at_company_level(product)

  sum <- unique(summarise(out, sum = sum(value), .by = grouped_by)$sum)
  expect_equal(sum, 1)
})

test_that("no match yields 1 row with NA in all columns (#393)", {
  companies <- example_companies(!!aka("uid") := "unmatched")
  products <- example_products()

  product <- emissions_profile_any_at_product_level(companies, products)
  out <- any_at_company_level(product)

  expect_equal(out$companies_id, "a")
  expect_equal(out$grouped_by, NA_character_)
  expect_equal(out$risk_category, NA_character_)
  expect_equal(out$value, NA_real_)
})

test_that("no match preserves companies", {
  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := c("a", "unmatched")
  )
  products <- example_products()

  product <- emissions_profile_any_at_product_level(companies, products)
  expect_equal(companies$company_id, unique(product$companies_id))
  company <- any_at_company_level(product)
  expect_equal(companies$company_id, unique(company$companies_id))

  companies <- example_companies(!!aka("uid") := "unmatched")
  product <- emissions_profile_any_at_product_level(companies, products)
  expect_equal(companies$company_id, product$companies_id)
  company <- any_at_company_level(product)
  expect_equal(companies$company_id, company$companies_id)

  companies <- example_companies(
    !!aka("id") := c("a", "b"),
    !!aka("uid") := "unmatched"
  )
  product <- emissions_profile_any_at_product_level(companies, products)
  expect_equal(companies$company_id, unique(product$companies_id))
  company <- any_at_company_level(product)
  expect_equal(companies$company_id, unique(company$companies_id))
})

test_that("some match yields (grouped_by * risk_category) rows with no NA (#393)", {
  companies <- example_companies(!!aka("uid") := c("a", "unmatched"))
  products <- example_products()

  product <- emissions_profile_any_at_product_level(companies, products)
  out <- any_at_company_level(product)

  expect_equal(nrow(out), 18L)
  n <- length(unique(out$grouped_by)) * length(unique(out$risk_category))
  expect_equal(n, 18L)
  expect_false(anyNA(out))
})

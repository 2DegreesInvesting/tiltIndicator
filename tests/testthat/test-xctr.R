test_that("hasn't change", {
  out <- xctr(companies, products) |>
    dplyr::arrange(companies_id) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("outputs expected columns at company level", {
  companies <- slice(companies, 1)
  co2 <- slice(products, 1)

  out <- xctr(companies, co2)

  expected <- cols_at_company_level()
  expect_equal(names(out)[seq_along(expected)], expected)
})

test_that("returns n rows equal to companies x risk_category x grouped_by", {
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
    isic_4digit = "4575"
  )
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )

  out <- xctr(companies, co2)

  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))

  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a", "b"),
    clustered = c("xyz", "abc")
  )

  out <- xctr(companies, co2)
  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))
})

test_that("if a company matches at least one input, each share sums 1 (#175)", {
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x", "y"),
    isic_4digit = "4575"
  )
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )

  out <- xctr(companies, co2)
  sum_of_each_share <- out |>
    group_by(grouped_by) |>
    summarize(sum = sum(value)) |>
    distinct(sum) |>
    pull()
  expect_equal(sum_of_each_share, 1)
})

test_that("if a company matches no co2, all shares are `NA` (#176)", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("y"),
    isic_4digit = "4575"
  )

  out <- xctr(companies, co2)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches at least one input, no share is `NA` (#176)", {
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
    isic_4digit = "4575"
  )
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )

  out <- xctr(companies, co2)
  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_false(any(share_is_na))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(companies, 1:2)
  co2 <- slice(products, 1:2)
  out1 <- xctr(companies, co2, low_threshold = .1)
  out2 <- xctr(companies, co2, low_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(companies, 1:2)
  co2 <- slice(products, 1:2)
  out1 <- xctr(companies, co2, high_threshold = .1)
  out2 <- xctr(companies, co2, high_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
    isic_4digit = "4575"
  )

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr(bad, co2), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(xctr(bad, co2), crucial)
})

test_that("if `co2` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
    clustered = c("xyz")
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
    isic_4digit = "4575"
  )

  crucial <- "co2_footprint"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "tilt_sector"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "unit"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(co2, -all_of(crucial))
  expect_error(xctr(companies, bad), crucial)

  crucial <- "isic_4digit"
  bad <- select(co2, -ends_with(crucial))
  expect_error(xctr(companies, bad), crucial)
})

test_that("if `co2` has 0-rows, the output is normal", {
  companies <- slice(companies, 1)

  co20 <- products[0, ]
  co21 <- products[1, ]
  out0 <- xctr(companies, co20)
  out1 <- xctr(companies, co21)

  expect_s3_class(out0, "tbl_df")
  expect_equal(names(out0), names(out1))
  expect_equal(nrow(out0), nrow(out1))
})

test_that("no longer drops companies depending on co2 data (#122)", {
  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- slice(products, 1:5)
  out <- xctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- slice(products, 1:4)
  out <- xctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- slice(products, 1:10)
  out <- xctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- tiltIndicator::companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- slice(products, 1:9)
  out <- xctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)
})

test_that("handles duplicated `companies` data (#230)", {
  companies <- tibble(
    company_id = rep("a", 2),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = c("c"),
    co2_footprint = 1,
    tilt_sector = "transport",
    unit = "metric ton*km",
    isic_4digit = "4575",
  )
  expect_no_error(xctr(companies, co2))
})

test_that("handles duplicated `co2` data (#230)", {
  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = rep("c", 2),
    co2_footprint = 1,
    tilt_sector = "transport",
    unit = "metric ton*km",
    isic_4digit = "4575",
  )
  expect_no_error(xctr(companies, co2))
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

  out <- xctr(companies, co2, low_threshold, high_threshold)
  expect_true(identical(unique(out$value), expected_value))
})

test_that("if the 'isic' column isn't a character, throws an error (#233)", {
  companies <- tibble(
    company_id = c("a"),
    clustered = c("b"),
    activity_uuid_product_uuid = c("c"),
  )
  co2 <- tibble(
    activity_uuid_product_uuid = c("c"),
    co2_footprint = 1,
    tilt_sector = "transport",
    unit = "metric ton*km",
    # Not a character
    isic_4digit = 4575,
  )

  expect_error(xctr(companies, co2), "must be.*character")
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

  out <- xctr(companies, co2)

  bad <- out |>
    count(grouped_by, risk_category) |>
    filter(n > 1) |>
    nrow()
  expect_equal(bad, 0)
})

test_that("a 0-row `co2` yields an error", {
  comp <- slice(companies, 1)
  prod <- products[0L, ]
  expect_error(xctr(comp, prod), "co2.*can't have 0-row")
})

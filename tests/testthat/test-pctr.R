test_that("hasn't change", {
  out <- format_robust_snapshot(pctr(pctr_companies, pctr_ecoinvent_co2))
  expect_snapshot(out)
})

test_that("outputs common output columns", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)

  out <- pctr(companies, co2)

  expected <- cols_at_company_level()
  expect_equal(names(out)[1:4], expected)
})

test_that("returns n rows equal to companies x risk_category x grouped_by", {
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
  )
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
  )

  out <- pctr(companies, co2)

  n <- length(unique(out$companies_id)) *
    length(unique(out$risk_category)) *
    length(unique(out$grouped_by))
  expect_equal(nrow(out), n)
  expect_equal(sort(unique(out$risk_category)), c("high", "low", "medium"))

  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a", "b"),
  )

  out <- pctr(companies, co2)
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
  )
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
  )

  out <- pctr(companies, co2)
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
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("y"),
  )

  out <- pctr(companies, co2)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches at least one input, no share is `NA` (#176)", {
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
  )
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
  )

  out <- pctr(companies, co2)
  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_false(any(share_is_na))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(pctr_companies, 1:2)
  co2 <- slice(pctr_ecoinvent_co2, 1:2)
  out1 <- pctr(companies, co2, low_threshold = .1)
  out2 <- pctr(companies, co2, low_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(pctr_companies, 1:2)
  co2 <- slice(pctr_ecoinvent_co2, 1:2)
  out1 <- pctr(companies, co2, high_threshold = .1)
  out2 <- pctr(companies, co2, high_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
  )

  crucial <- "activity_uuid_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(pctr(bad, co2), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(pctr(bad, co2), crucial)
})

test_that("if `co2` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_uuid_product_uuid = c("x"),
    company_id = c("a"),
  )
  co2 <- tibble(
    co2_footprint = 1,
    tilt_sector = "Transport",
    unit = "metric ton*km",
    activity_uuid_product_uuid = c("x"),
  )

  crucial <- "co2_footprint"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)

  crucial <- "tilt_sector"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)

  crucial <- "unit"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)

  crucial <- "activity_uuid_product_uuid"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)
})

test_that("if `co2` has 0-rows, the output is normal", {
  companies <- slice(pctr_companies, 1)

  co20 <- pctr_ecoinvent_co2[0, ]
  co21 <- pctr_ecoinvent_co2[1, ]
  out0 <- pctr(companies, co20)
  out1 <- pctr(companies, co21)

  expect_s3_class(out0, "tbl_df")
  expect_equal(names(out0), names(out1))
  expect_equal(nrow(out0), nrow(out1))
})

test_that("no longer drops companies depending on co2 data (#122)", {
  companies <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- slice(pctr_ecoinvent_co2, 1:5)
  out <- pctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  co2 <- slice(pctr_ecoinvent_co2, 1:4)
  out <- pctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- slice(pctr_ecoinvent_co2, 1:10)
  out <- pctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)

  companies <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])
  co2 <- slice(pctr_ecoinvent_co2, 1:9)
  out <- pctr(companies, co2)
  expect_equal(length(unique(out$companies_id)), 2L)
})

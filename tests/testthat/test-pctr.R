test_that("hasn't change", {
  out <- format_robust_snapshot(pctr(pctr_companies, pctr_ecoinvent_co2))
  expect_snapshot(out)
})

test_that("outputs columns for ids, risk categories, and shares", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr(companies, co2)

  expected <- c(
    "id",
    "transition_risk",
    "score_all",
    "score_unit",
    # FIXME: "score_sector" is missing (#191)
    "score_unit_sec"
  )
  expect_equal(names(out)[1:5], expected)
})

test_that("returns 3 rows per company, for risk 'low', 'medium', and 'high'", {
  co2 <- tibble(
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    activity_product_uuid = c("x"),
  )
  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a"),
  )

  out <- pctr(companies, co2)

  expect_equal(nrow(out), 3L)
  expect_equal(sort(unique(out$transition_risk)), c("high", "low", "medium"))

  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a", "b"),
  )

  out <- pctr(companies, co2)
  expect_equal(nrow(out), 6L)
  expect_equal(sort(unique(out$transition_risk)), c("high", "low", "medium"))
})

test_that("if a company matches at least one input, each share sums 1 (#175)", {
  co2 <- tibble(
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    activity_product_uuid = c("x", "y"),
  )
  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a"),
  )

  out <- pctr(companies, co2)
  sum_of_each_share <- unique(sapply(select(out, starts_with("score")), sum))
  expect_equal(sum_of_each_share, 1)
})

test_that("if a company matches no co2, all shares are `NA` (#176)", {
  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a"),
  )
  co2 <- tibble(
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    activity_product_uuid = c("y"),
  )

  out <- pctr(companies, co2)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

test_that("if a company matches at least one input, no share is `NA` (#176)", {
  co2 <- tibble(
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    activity_product_uuid = c("x"),
  )
  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a"),
  )

  out <- pctr(companies, co2)
  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_false(any(share_is_na))
})

test_that("is sensitive to low_threshold", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1:3)
  out1 <- pctr(companies, co2, low_threshold = .1)
  out2 <- pctr(companies, co2, low_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("is sensitive to high_threshold", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1:3)
  out1 <- pctr(companies, co2, high_threshold = .1)
  out2 <- pctr(companies, co2, high_threshold = .9)
  expect_false(identical(out1, out2))
})

test_that("if `companies` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a"),
  )
  co2 <- tibble(
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    activity_product_uuid = c("x"),
  )

  crucial <- "activity_product_uuid"
  bad <- select(companies, -all_of(crucial))
  expect_error(pctr(bad, co2), crucial)

  crucial <- "company_id"
  bad <- select(companies, -all_of(crucial))
  expect_error(pctr(bad, co2), crucial)
})

test_that("if `co2` lacks crucial columns, errors gracefully", {
  companies <- tibble(
    activity_product_uuid = c("x"),
    company_id = c("a"),
  )
  co2 <- tibble(
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    activity_product_uuid = c("x"),
  )

  crucial <- "co2_footprint"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)

  crucial <- "sec"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)

  crucial <- "unit"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)

  crucial <- "activity_product_uuid"
  bad <- select(co2, -all_of(crucial))
  expect_error(pctr(companies, bad), crucial)
})

test_that("if `companies` has 0-rows, returns a well structured 0-row output", {
  co2 <- pctr_ecoinvent_co2

  companies0 <- pctr_companies[0, ]
  companies1 <- pctr_companies[1, ]
  out0 <- pctr(companies0, co2)
  out1 <- pctr(companies1, co2)

  expect_s3_class(out0, "tbl_df")
  expect_equal(names(out0), names(out1))
  expect_equal(nrow(out0), 0)
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

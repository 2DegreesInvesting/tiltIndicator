test_that("the head hasn't changed", {
  companies <- distinct(pctr_companies, company_id, .keep_all = TRUE) |>
    slice(1)
  co2 <- pctr_ecoinvent_co2

  data <- pctr_score_activities(co2)
  out <- pctr_score_companies(data, slice(companies, 1))
  expect_snapshot(out)
})

test_that("without crucial columns in `pctr_companies` throws an error", {
  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  bad_companies <- pctr_companies |>
    slice(1) |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"company_id")
  expect_error(pctr_score_companies(data, bad_companies), "company_id")

  bad_companies <- pctr_companies |>
    slice(1) |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"activity_product_uuid")
  expect_error(pctr_score_companies(data, bad_companies), "activity_product_uuid")
})

test_that("without crucial columns in `pctr_ecoinvent_co2` errors gracefully", {
  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  bad_data <- select(data, -"score_unit_sec")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "hasName.*not")

  bad_data <- select(data, -"score_all")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "hasName.*not")

  bad_data <- select(data, -"score_unit")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "hasName.*not")

  bad_data <- select(data, -"activity_product_uuid")
  expect_error(
    pctr_score_companies(bad_data, pctr_companies), "activity_product_uuid"
  )
})

test_that("no longer drops companies depending on co2 data (#122)", {
  companies <- pctr_companies

  good_co2_slice <- slice(pctr_ecoinvent_co2, 1:5)
  companies_1_2 <- filter(companies, company_id %in% unique(company_id)[c(1, 2)])
  data <- pctr_score_activities(good_co2_slice)
  out <- pctr_score_companies(data, companies_1_2)
  expect_equal(length(unique(out$company_id)), 2L)

  bad_co2_slice <- slice(pctr_ecoinvent_co2, 1:4)
  companies_1_2 <- filter(companies, company_id %in% unique(company_id)[c(1, 2)])
  data <- pctr_score_activities(bad_co2_slice)
  out <- pctr_score_companies(data, companies_1_2)
  expect_equal(length(unique(out$company_id)), 2L)

  another_good_co2_slice <- slice(pctr_ecoinvent_co2, 1:10)
  companies_1_3 <- filter(companies, company_id %in% unique(company_id)[c(1, 3)])
  data <- pctr_score_activities(another_good_co2_slice)
  out <- pctr_score_companies(data, companies_1_3)
  expect_equal(length(unique(out$company_id)), 2L)

  another_bad_co2_slice <- slice(pctr_ecoinvent_co2, 1:9)
  companies_1_3 <- filter(companies, company_id %in% unique(company_id)[c(1, 3)])
  data <- pctr_score_activities(another_bad_co2_slice)
  out <- pctr_score_companies(data, companies_1_3)
  expect_equal(length(unique(out$company_id)), 2L)
})

test_that("returns 3 rows for each company", {
  companies <- distinct(pctr_companies, company_id, .keep_all = TRUE)
  co2 <- pctr_ecoinvent_co2

  data <- pctr_score_activities(co2)
  out <- pctr_score_companies(data, slice(companies, 1))
  expect_equal(nrow(out), 3L)

  data <- pctr_score_activities(co2)
  out <- pctr_score_companies(data, slice(companies, 1:2))
  expect_equal(nrow(out), 6L)

  data <- pctr_score_activities(co2)
  out <- pctr_score_companies(data, slice(companies, 1:3))
  expect_equal(nrow(out), 9L)
})

test_that("outputs an id for each company and a score", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)
  data <- pctr_score_activities(co2)

  out <- pctr_score_companies(data, companies)
  expect_true(hasName(out, "company_id"))
  expect_true(hasName(out, "score"))
})

test_that("with uuid in companies absent in inputs, all shares sum 1 (#173)", {
  companies <- tibble(
    company_id = "id",
    activity_product_uuid = c("v", "x")
  )
  co2 <- tibble(
    activity_product_uuid = c("v"),
    co2_footprint = 1,
    sec = "Transport",
    unit = "metric ton*km",
    ei_activity = "transport, freight, lorry 7.5-16 metric ton, EURO3"
  )

  out <- co2 |>
    pctr_score_activities() |>
    pctr_score_companies(companies)

  summed <- summarize(out, across(starts_with("share_"), sum))
  all_sahre_sum_1 <- all(unlist(summed) == 1)
  expect_true(all_sahre_sum_1)
})

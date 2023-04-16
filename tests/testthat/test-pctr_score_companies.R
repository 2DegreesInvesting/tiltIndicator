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

  bad_companies <- pctr_companies |>
    slice(1) |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"ei_activity")
  expect_error(pctr_score_companies(data, bad_companies), "ei_activity")

  bad_companies <- pctr_companies |>
    slice(1) |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"unit")
  expect_error(pctr_score_companies(data, bad_companies), "unit")
})

test_that("without crucial columns errors gracefully", {
  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  bad_data <- select(data, -"unit")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "unit")

  bad_data <- select(data, -"score_unit_sec")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "score_unit_sec")

  bad_data <- select(data, -"ei_activity")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "ei_activity")

  bad_data <- select(data, -"score_all")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "score_all")

  bad_data <- select(data, -"score_unit")
  expect_error(pctr_score_companies(bad_data, pctr_companies), "score_unit")

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

test_that("FIXME: Under 5 co2 rows some company gets all 0 without warning", {
  companies <- filter(pctr_companies, company_id %in% unique(company_id)[c(1, 2)])

  enough_co2 <- slice(pctr_ecoinvent_co2, 1:5)
  data <- pctr_score_activities(enough_co2)
  expect_no_warning(out <- pctr_score_companies(data, companies))
  out <- pctr_score_companies(data, companies)
  sum_of_share_by_company <- out |>
    group_by(company_id) |>
    dplyr::rowwise() |>
    dplyr::reframe(share = sum(dplyr::c_across(starts_with("share_")))) |>
    group_by(company_id) |>
    dplyr::summarise(share = sum(share)) |>
    dplyr::pull()
  expect_false(any(sum_of_share_by_company == 0))

  insufficient_co2 <- slice(pctr_ecoinvent_co2, 1)
  data <- pctr_score_activities(insufficient_co2)
  # FIXME We may need a warning
  expect_no_warning(out <- pctr_score_companies(data, companies))
  sum_of_share_by_company <- out |>
    group_by(company_id) |>
    dplyr::rowwise() |>
    dplyr::reframe(share = sum(dplyr::c_across(starts_with("share_")))) |>
    group_by(company_id) |>
    dplyr::summarise(share = sum(share)) |>
    dplyr::pull()
  FIXME_expected_false <- any(sum_of_share_by_company == 0)
  expect_true(FIXME_expected_false)

  insufficient_co2 <- slice(pctr_ecoinvent_co2, 1:4)
  data <- pctr_score_activities(insufficient_co2)
  # FIXME We may need a warning
  expect_no_warning(out <- pctr_score_companies(data, companies))
  sum_of_share_by_company <- out |>
    group_by(company_id) |>
    dplyr::rowwise() |>
    dplyr::reframe(share = sum(dplyr::c_across(starts_with("share_")))) |>
    group_by(company_id) |>
    dplyr::summarise(share = sum(share)) |>
    dplyr::pull()
  FIXME_expected_false <- any(sum_of_share_by_company == 0)
  expect_true(FIXME_expected_false)
})

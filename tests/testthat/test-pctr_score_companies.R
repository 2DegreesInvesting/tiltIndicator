test_that("hasn't changed", {
  out <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    pctr_score_companies(pctr_companies) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("with crucial columns in `pctr_ecoinvent_co2` throws no error", {
  data <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  expect_no_error(pctr_score_companies(data, pctr_companies))
})

test_that("with crucial columns in `pctr_companies` throws no error", {
  data <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  crucial_companies <- pctr_companies |>
    select(all_of(pctr_companies_crucial()))
  pctr_score_companies(data, crucial_companies) |>
    expect_no_error()
})

test_that("without crucial columns in `pctr_companies` throws an error", {
  data <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  bad_companies <- pctr_companies |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"company_id")
  pctr_score_companies(data, bad_companies) |>
    expect_error("company_id")

  bad_companies <- pctr_companies |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"activity_product_uuid")
  pctr_score_companies(data, bad_companies) |>
    expect_error("activity_product_uuid")

  bad_companies <- pctr_companies |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"ei_activity")
  pctr_score_companies(data, bad_companies) |>
    expect_error("ei_activity")

  bad_companies <- pctr_companies |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"unit")
  pctr_score_companies(data, bad_companies) |>
    expect_error("unit")
})

test_that("without crucial columns errors gracefully", {
  data <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  data |>
    select(-"unit") |>
    pctr_score_companies(pctr_companies) |>
    expect_error("unit")

  data |>
    select(-"score_unit_sec") |>
    pctr_score_companies(pctr_companies) |>
    expect_error("score_unit_sec")

  data |>
    select(-"ei_activity") |>
    pctr_score_companies(pctr_companies) |>
    expect_error("ei_activity")

  data |>
    select(-"activity_product_uuid") |>
    pctr_score_companies(pctr_companies) |>
    expect_error("activity_product_uuid")

  data |>
    select(-"score_all") |>
    pctr_score_companies(pctr_companies) |>
    expect_error("score_all")

  data |>
    select(-"score_unit") |>
    pctr_score_companies(pctr_companies) |>
    expect_error("score_unit")
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

  out <- co2 |>
    pctr_score_activities() |>
    pctr_score_companies(companies |> slice(1))
  expect_equal(nrow(out), 3L)

  out <- co2 |>
    pctr_score_activities() |>
    pctr_score_companies(companies |> slice(1:2))
  expect_equal(nrow(out), 6L)

  out <- co2 |>
    pctr_score_activities() |>
    pctr_score_companies(companies |> slice(1:3))
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

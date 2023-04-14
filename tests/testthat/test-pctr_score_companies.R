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

test_that("FIXME co2 data must have a mysterious number of rows that depends on the specific companies chosen -- else the output looses companies", {
  # Expected
  odd_boundary_1_5 <- pctr_ecoinvent_co2 |> slice(1:5)
  companies_1_2 <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  out <- odd_boundary_1_5 |>
    pctr_score_activities() |>
    pctr_score_companies(companies_1_2)
  expect_equal(length(unique(out$company_id)), 2L)

  # Unexpected
  below_odd_boundary_1_5 <- pctr_ecoinvent_co2 |> slice(1:4)
  companies_1_2 <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 2)])
  out <- below_odd_boundary_1_5 |>
    pctr_score_activities() |>
    pctr_score_companies(companies_1_2)
  FIXME_expected_2 <- 1L
  expect_equal(length(unique(out$company_id)), FIXME_expected_2)

  # Different companies impose a different boundary
  # Expected
  odd_boundary_1_10 <- pctr_ecoinvent_co2 |> slice(1:10)
  companies_1_3 <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])

  out <- odd_boundary_1_10 |>
    pctr_score_activities() |>
    pctr_score_companies(companies_1_3)
  expect_equal(length(unique(out$company_id)), 2L)

  # Unexpected
  below_odd_boundary_1_10 <- pctr_ecoinvent_co2 |> slice(1:9)
  companies_1_3 <- pctr_companies |>
    filter(company_id %in% unique(company_id)[c(1, 3)])

  out <- below_odd_boundary_1_10 |>
    pctr_score_activities() |>
    pctr_score_companies(companies_1_3)
  FIXME_expected_2 <- 1L
  expect_equal(length(unique(out$company_id)), FIXME_expected_2)
})

test_that("returns 3 rows for each company", {
  # Keep all columns picking the first row for each non-unique combination
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

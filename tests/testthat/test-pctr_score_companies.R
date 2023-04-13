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

test_that("the number of required data rows is hard to predict", {
  data <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  data |>
    slice(1L) |>
    pctr_score_companies(pctr_companies) |>
    expect_no_error()
  data |>
    slice(1:15) |>
    pctr_score_companies(pctr_companies) |>
    expect_no_error()
  data |>
    slice(4:15) |>
    pctr_score_companies(pctr_companies) |>
    expect_no_error()
  data |>
    slice(5:15) |>
    pctr_score_companies(pctr_companies) |>
    expect_no_error()
})

test_that("the number of required pctr_companies rows is hard to predict", {
  data <- pctr_ecoinvent_co2 |>
    pctr_score_activities() |>
    select(all_of(pctr_score_companies_crucial()))

  data |>
    pctr_score_companies(pctr_companies |> slice(1)) |>
    expect_no_error()
  data |>
    pctr_score_companies(pctr_companies |> slice(1:15)) |>
    expect_no_error()
  data |>
    pctr_score_companies(pctr_companies |> slice(4:15)) |>
    expect_no_error()
  data |>
    pctr_score_companies(pctr_companies |> slice(5:15)) |>
    expect_no_error()
})

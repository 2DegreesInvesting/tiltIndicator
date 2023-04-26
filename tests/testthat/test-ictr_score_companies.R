test_that("hasn't change", {
  out <- ictr_inputs |>
    ictr_score_inputs() |>
    ictr_score_companies(ictr_companies) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("data must have activity_uuid_product_uuid", {
  data <- slice(ictr_inputs, 1L) |>
    select(-"activity_uuid_product_uuid") |>
    ictr_score_inputs()
  expect_error(
    ictr_score_companies(data, ictr_companies),
    "activity_uuid_product_uuid"
  )
})

test_that("with invalid inputs all shares are 0 with no warning or error", {
  data <- slice(ictr_inputs, 1) |>
    mutate(activity_uuid_product_uuid = "bad") |>
    ictr_score_inputs()

  out <- data |>
    ictr_score_companies(ictr_companies) |>
    expect_no_warning() |>
    expect_no_error()

  share <- out |>
    select(starts_with("share_")) |>
    sapply(unique) |>
    unique()
  expect_true(identical(share, 0))
})

test_that("with valid inputs not all shares are 0", {
  data <- ictr_score_inputs(slice(ictr_inputs, 1))

  out <- ictr_score_companies(data, ictr_companies)

  share <- out |>
    select(starts_with("share_")) |>
    sapply(unique) |>
    unique()
  expect_false(identical(share, 0))
})

test_that("returns 3 rows per company for any slice of companies", {
  two_inputs <- slice(ictr_inputs, 1:2)
  data <- ictr_score_inputs(two_inputs)

  one_company <- distinct(ictr_companies, company_id, .keep_all = TRUE) |>
    slice(1)
  out <- ictr_score_companies(data, one_company)
  expect_equal(nrow(out), 3L)

  three_companies <- distinct(ictr_companies, company_id, .keep_all = TRUE) |>
    slice(1:3)
  out <- ictr_score_companies(data, three_companies)
  expect_equal(nrow(out), 9L)
})

test_that("returns 3 rows per company for any slice of inputs", {
  two_companies <- distinct(ictr_companies, company_id, .keep_all = TRUE) |>
    slice(1:2)

  one_inputs <- slice(ictr_inputs, 1)
  data <- ictr_score_inputs(one_inputs)
  out <- ictr_score_companies(data, two_companies)
  expect_equal(nrow(out), 6L)

  three_inputs <- slice(ictr_inputs, 1:3)
  data <- ictr_score_inputs(three_inputs)
  out <- ictr_score_companies(data, two_companies)
  expect_equal(nrow(out), 6L)
})

test_that("with a missing value in inputs_co2 errors gracefully", {
  data <- ictr_score_inputs(slice(ictr_inputs, 1))
  data$input_co2 <- NA
  companies <- slice(ictr_companies, 1)
  expect_error(ictr_score_companies(data, companies), "input_co2.*missing")
})

test_that("outputs an id for each company and a score", {
  inputs <- ictr_score_inputs(slice(ictr_inputs, 1))
  data <- ictr_score_inputs(inputs)

  companies <- slice(ictr_companies, 1)
  out <- ictr_score_companies(data, companies)

  expect_true(hasName(out, "company_id"))
  expect_true(hasName(out, "score"))
})

test_that("Data in `share` columns for all three risk categories sums up to 1", {
  company <- ictr_companies |> filter(company_id %in% first(company_id))
  inputs <- ictr_inputs |> slice(1)

  sample_output <- inputs |>
    ictr_score_inputs() |>
    ictr_score_companies(company)

  new_output <- column_sum_checker(
    sum_all = sum(sample_output$share_all),
    sum_unit = sum(sample_output$share_unit),
    sum_sector = sum(sample_output$share_sector),
    sum_unit_sec = sum(sample_output$share_unit_sec)
  )

  correct_output <- column_sum_checker()
  testthat::expect_true(identical(new_output, correct_output))
})

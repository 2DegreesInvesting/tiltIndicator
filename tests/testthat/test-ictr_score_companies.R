test_that("hasn't change", {
  out <- ictr_inputs |>
    ictr_score_inputs() |>
    ictr_score_companies(ictr_companies) |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("data must have activity_product_uuid and ei_activity", {
  ictr_toy_inputs() |>
    ictr_score_inputs() |>
    ictr_score_companies(ictr_companies) |>
    expect_error("activity_product_uuid.*ei_activity")

  ictr_toy_inputs(activity_product_uuid = "any", ei_activity = "thing") |>
    ictr_score_inputs() |>
    ictr_score_companies(ictr_companies) |>
    expect_no_error()
})

test_that("with invalid inputs all shares are 0 with no error or warning", {
  data <- ictr_toy_inputs2(activity_product_uuid = "bad", ei_activity = "bad") |>
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
  data <- ictr_toy_inputs2() |>
    ictr_score_inputs()

  out <- data |>
    ictr_score_companies(ictr_companies)

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

test_that("without `company_name` and `ep_product` outputs are the same", {
  data <- ictr_toy_inputs2() |> ictr_score_inputs()

  companies <- ictr_toy_companies() |>
    mutate(company_name = "any", ep_product = "any")
  out1 <- data |>
    ictr_score_companies(companies) |>
    expect_no_error()

  without <- ictr_toy_companies()
  out2 <- data |>
    ictr_score_companies(without) |>
    expect_no_error()

  expect_equal(out1, out2)
})

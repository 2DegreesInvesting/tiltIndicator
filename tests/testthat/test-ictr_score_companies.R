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

test_that("the ictr_companies dataset must have some mysterious rows", {
  data <- ictr_toy_inputs2() |>
    ictr_score_inputs()

  data |>
    ictr_score_companies(ictr_companies |> slice(1:14)) |>
    expect_no_error()

  data |>
    ictr_score_companies(ictr_companies |> slice(7:15)) |>
    expect_no_error()
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

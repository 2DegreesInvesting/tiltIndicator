test_that("outputs the expected columns", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)
  out <- ictr(companies, inputs)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))

  expected <- c(
    "id",
    "transition_risk",
    "score_all",
    "score_unit",
    "score_sector",
    "score_unit_sec"
  )
  expect_equal(names(out)[1:6], expected)
})

test_that("outputs the expected columns", {
  companies <- slice(ictr_companies, 1)
  inputs <- slice(ictr_inputs, 1)
  out <- ictr(companies, inputs)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("if a company matches no inputs, all shares are `NA` (#176)", {
  companies <- tibble(
    company_id = "a",
    activity_uuid_product_uuid = "a"
  )
  inputs <- tibble(
    activity_uuid_product_uuid = "b",
    input_co2 = 1,
    input_sector = "transport",
    unit = "metric ton*km",
  )

  out <- ictr(companies, inputs)

  all_is_na <- all(is.na(unlist(select(out, starts_with("score")))))
  expect_true(all_is_na)
})

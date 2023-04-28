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
    company_id = c("a", "c", "c", "d"),
    activity_uuid_product_uuid = c("a", "x", "y", "z")
  )
  inputs <- tibble(
    activity_uuid_product_uuid = c("b", "x"),
    input_co2 = c(1, 3),
    input_sector = c("transport", "transport"),
    unit = c("metric ton*km", "metric ton*km"),
  )

  out <- ictr(companies, inputs)

  summed <- out |>
    group_by(id) |>
    summarize(across(starts_with("score_"), sum))
  ids_for_na <- summed$id[is.na(summed$score_all) &
    is.na(summed$score_unit) &
    is.na(summed$score_sector) &
    is.na(summed$score_unit_sec)]

  all_is_na <- all(is.na(unlist(out |>
    filter(id %in% ids_for_na) |>
    select(starts_with("score")))))
  expect_true(all_is_na)
})

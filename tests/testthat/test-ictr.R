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

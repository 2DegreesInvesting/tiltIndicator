test_that("outputs the expected columns", {
  scenarios <- pstr_new_dataset_scenarios()
  companies <- pstr_new_dataset_companies()

  out <- pstr(companies, scenarios)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
  expect_equal(names(out)[1:3], c("id", "transition_risk", "score_aggregated"))
})

test_that("the output is not grouped", {
  scenarios <- pstr_new_dataset_scenarios()
  companies <- pstr_new_dataset_companies()

  out <- pstr(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

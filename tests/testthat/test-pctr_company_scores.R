test_that("hasn't changed", {
  skip_on_ci()

  testthat::local_edition(3)
  set.seed(123)

  options(readr.show_col_types = FALSE)
  input1 <- readr::read_csv(pctr_path("input_data", "ecoinvent_activities.csv"))
  input2 <- readr::read_csv(pctr_path("input_data", "MVP_sample_dataset.csv"))
  out <- pctr_company_scores(input1, input2)
  out <- format_robust_snapshot(out)

  expect_snapshot(out)
})

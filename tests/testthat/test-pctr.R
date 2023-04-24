test_that("outputs the expected columns", {
  companies <- slice(pctr_companies, 1)
  ecoinvent_co2 <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr(companies, ecoinvent_co2)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))

  expected <- c(
    "id",
    "transition_risk",
    "score_all",
    "score_unit",
    # 191
    # "score_sector",
    "score_unit_sec"
  )
  expect_equal(names(out)[1:5], expected)
})

test_that("outputs the expected columns", {
  companies <- slice(pctr_companies, 1)
  ecoinvent_co2 <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr(companies, ecoinvent_co2)
  expect_false(dplyr::is_grouped_df(out))
})

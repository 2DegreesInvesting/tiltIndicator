test_that("outputs the expected columns", {
  companies <- slice(pctr_companies, 1)
  ecoinvent_co2 <- slice(pctr_ecoinvent_co2, 1)
  out <- pctr(companies, ecoinvent_co2)

  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
})

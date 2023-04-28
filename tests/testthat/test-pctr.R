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

test_that("if a company matches no inputs, all shares are `NA` (#176)", {
  companies <- tibble(
      company_id = "a",
      activity_product_uuid = "a",
  )
  ecoinvent_co2 <- tibble(
      activity_product_uuid = "b",
      co2_footprint = 2,
      sec = "Transport",
      unit = "metric ton*km",
  )

  out <- pctr(companies, ecoinvent_co2)

  share_is_na <- is.na(unlist(select(out, starts_with("score"))))
  expect_true(all(share_is_na))
})

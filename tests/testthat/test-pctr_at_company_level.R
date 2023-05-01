test_that("without crucial columns in `pctr_companies` throws an error", {
  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    pctr_score_activities() |>
    select(all_of(pctr_at_company_level_crucial()))

  bad_companies <- pctr_companies |>
    slice(1) |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"company_id")
  expect_error(pctr_at_company_level(data, bad_companies), "company_id")

  bad_companies <- pctr_companies |>
    slice(1) |>
    select(all_of(pctr_companies_crucial())) |>
    select(-"activity_product_uuid")
  expect_error(pctr_at_company_level(data, bad_companies), "activity_product_uuid")
})

test_that("without crucial columns in `pctr_ecoinvent_co2` errors gracefully", {
  data <- pctr_ecoinvent_co2 |>
    slice(1) |>
    pctr_score_activities() |>
    select(all_of(pctr_at_company_level_crucial()))

  bad_data <- select(data, -"score_unit_sec")
  expect_error(pctr_at_company_level(bad_data, pctr_companies), "score_unit_sec")

  bad_data <- select(data, -"score_all")
  expect_error(pctr_at_company_level(bad_data, pctr_companies), "score_all")

  bad_data <- select(data, -"score_unit")
  expect_error(pctr_at_company_level(bad_data, pctr_companies), "score_unit")

  bad_data <- select(data, -"activity_product_uuid")
  expect_error(
    pctr_at_company_level(bad_data, pctr_companies), "activity_product_uuid"
  )
})

test_that("returns 3 rows for each company", {
  companies <- distinct(pctr_companies, company_id, .keep_all = TRUE)
  co2 <- pctr_ecoinvent_co2

  data <- pctr_score_activities(co2)
  out <- pctr_at_company_level(data, slice(companies, 1))
  expect_equal(nrow(out), 3L)

  data <- pctr_score_activities(co2)
  out <- pctr_at_company_level(data, slice(companies, 1:2))
  expect_equal(nrow(out), 6L)

  data <- pctr_score_activities(co2)
  out <- pctr_at_company_level(data, slice(companies, 1:3))
  expect_equal(nrow(out), 9L)
})

test_that("outputs an id for each company and a score", {
  companies <- slice(pctr_companies, 1)
  co2 <- slice(pctr_ecoinvent_co2, 1)
  data <- pctr_score_activities(co2)

  out <- pctr_at_company_level(data, companies)
  expect_true(hasName(out, "company_id"))
  expect_true(hasName(out, "score"))
})

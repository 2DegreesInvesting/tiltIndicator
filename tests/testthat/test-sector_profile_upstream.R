test_that("accepts `company_id` with a warning (#564)", {
  companies <- example_companies() |> rename(company_id = companies_id)
  inputs <- example_inputs()
  scenarios <- example_scenarios()

  expect_no_error(
    expect_warning(
      sector_profile_upstream(companies, scenarios, inputs),
      class = "rename_id"
    )
  )
})

test_that("at product level, preserves unmatched companies", {
  companies <- example_companies(
    !!aka("id") := c("a", "unmatched"),
    !!aka("uid") := c("a", "unmatched"),
  )
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := c("total"),
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("id")]])
})

test_that("at product level, preserves unmatched products", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
  )
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := c("total"),
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("uid")]])
})

test_that("at product level, unmatched product yield `NA` in the expected columns", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
  )
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := c("total"),
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |>
    unnest_product() |>
    filter(.data[[aka("uid")]] == "unmatched")

  expect_true(is.na(out$grouped_by))
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))
})

test_that("at company level, `risk_category` always has the value `NA` (#638)", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()

  out <- sector_profile_upstream(companies, scenarios, inputs) |> unnest_company()

  expect_true(anyNA(out$risk_category))
})

test_that("at company level with one company, a company with one unmatched product yields 1 row", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := "unmatched",
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |> unnest_company()
  expect_equal(nrow(out), 1)
})

test_that("at company level with two companies, a company with one unmatched product yields 1 row", {
  companies <- example_companies(
    !!aka("id") := c("a", "unmatched"),
    !!aka("uid") := c("a", "unmatched"),
  )
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := c("total"),
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |>
    unnest_company() |>
    filter(.data[[aka("id")]] == "unmatched")

  expect_equal(nrow(filter(out)), 1)
})

test_that("at company level, one matched and one unmatched products yield `value = 1/2` where `risk_category = NA` and in one other `risk_category` (#657)", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
  )
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := c("total"),
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |>
    unnest_company() |>
    distinct(risk_category, value)

  na <- pull(filter(out, is.na(risk_category)), value)
  expect_equal(na, 1 / 2)
  other <- pull(filter(out, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 1 / 2))
})

test_that("at company level, two matched and one unmatched products yield `value = 1/3` where `risk_category = NA` and `value = 2/3` in one other `risk_category` (#657)", {
  companies <- example_companies(
    !!aka("uid") := c("a", "b", "unmatched"),
  )
  scenarios <- example_scenarios()
  inputs <- example_inputs(
    !!aka("xsector") := c("total", "total"),
    !!aka("uid") := c("a", "b"),
  )

  out <- sector_profile_upstream(companies, scenarios, inputs) |>
    unnest_company() |>
    distinct(risk_category, value)

  na <- pull(filter(out, is.na(risk_category)), value)
  expect_equal(na, 1 / 3)
  other <- pull(filter(out, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 2 / 3))
})

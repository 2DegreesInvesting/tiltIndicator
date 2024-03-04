test_that("accepts `company_id` with a warning (#564)", {
  companies <- example_companies() |> rename(company_id = companies_id)
  scenarios <- example_scenarios()

  expect_no_error(
    expect_warning(
      sector_profile(companies, scenarios),
      class = "rename_id"
    )
  )
})

test_that("at product level, preserves unmatched companies", {
  companies <- example_companies(
    !!aka("id") := c("a", "unmatched"),
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("id")]])
})

test_that("at product level, preserves unmatched products", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("uid")]])
})

test_that("at product level, unmatched product yield `NA` in the expected columns", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
    unnest_product() |>
    filter(.data[[aka("uid")]] == "unmatched")

  expect_true(is.na(out$grouped_by))
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))
})

test_that("at company level, `risk_category` always has the value `NA` (#638)", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_company()
  expect_true(anyNA(out$risk_category))
})

test_that("at company level with one company, a company with one unmatched product yields 1 row", {
  companies <- example_companies(
    !!aka("xsector") := "unmatched",
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_company()
  expect_equal(nrow(out), 1)
})

test_that("at company level with two companies, a company with one unmatched product yields 1 row", {
  companies <- example_companies(
    !!aka("id") := c("a", "unmatched"),
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
    unnest_company() |>
    filter(.data[[aka("id")]] == "unmatched")

  expect_equal(nrow(filter(out)), 1)
})

test_that("at company level, one matched and one unmatched products yield `value = 1/2` where `risk_category = NA` and in one other `risk_category` (#657)", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
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
    !!aka("xsector") := c("total", "total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
    unnest_company() |>
    distinct(risk_category, value)

  na <- pull(filter(out, is.na(risk_category)), value)
  expect_equal(na, 1 / 3)
  other <- pull(filter(out, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 2 / 3))
})

test_that("at product level, `NA` in a benchmark yields `NA` in `risk_category` and `profile_ranking` (#638)", {
  companies <- example_companies()
  benchmark <- aka("xsector")
  scenarios <- example_scenarios("{ benchmark }" := NA)

  out <- sector_profile(companies, scenarios) |>
    unnest_product()

  expect_equal(nrow(out), 1)
  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))
})

test_that("behaves as Tilman expects", {
  companies <- example_companies(
    !!aka("uid") := "unmatched",
    !!aka("scenario_type") := c("ipr", "weo"),
    !!aka("xsector") := c("land use", NA),
    !!aka("xsubsector") := c("land use", NA)
  )

  scenarios <- example_scenarios(
    !!aka("scenario_type") := c("weo", "ipr"),
    !!aka("xsector") := c("total", "land use"),
    !!aka("xsubsector") := c("energy", "land use")

  )

  sector_profile(companies, scenarios) |> unnest_product()
  sector_profile(companies, scenarios) |> unnest_company()
})

test_that("at product level, `NA` in a benchmark yields `NA`s only in the corresponding product (#638)", {
  companies <- example_companies(
    !!aka("id") := c("a", "a"),
    !!aka("uid") := c("a", "b"),
    !!aka("cluster") := c("a", "b"),
    !!aka("xsector") := c("total", NA),
  )

  benchmark <- aka("xsector")
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
    unnest_product()

  expect_false(is.na(filter(out, .data[[aka("cluster")]] == "a")$grouped_by))
  expect_false(is.na(filter(out, .data[[aka("cluster")]] == "a")$risk_category))

  expect_true(is.na(filter(out, .data[[aka("cluster")]] == "b")$risk_category))
  expect_false(is.na(filter(out, .data[[aka("cluster")]] == "b")$grouped_by))
})

test_that("at company level, `NA` in a benchmark yields `NA` in `risk_category` and not in `value` (#638)", {
  companies <- example_companies(
    !!aka("xsector") := NA
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_company()
  expect_true(anyNA(out$risk_category))
  expect_false(anyNA(out$value))
})

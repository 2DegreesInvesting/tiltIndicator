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

test_that("is a profile", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios)

  expect_s3_class(out, "tilt_profile")
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
    !!aka("cluster") := c("matched", "unmatched"),
    !!aka("xsector") := c("matched", "unmatched")
  )
  scenarios <- example_scenarios(
    !!aka("xsector") := c("matched")
  )

  out <- sector_profile(companies, scenarios) |> unnest_product()

  expect_true("unmatched" %in% out[[aka("cluster")]])
})

test_that("at product level, unmatched product yield `NA` in the expected columns", {
  companies <- example_companies(
    !!aka("cluster") := c("matched", "unmatched"),
    !!aka("xsector") := c("matched", "unmatched")
  )
  scenarios <- example_scenarios(
    !!aka("xsector") := c("matched")
  )

  out <- sector_profile(companies, scenarios) |>
    unnest_product() |>
    filter(.data[[aka("cluster")]] == "unmatched")

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
    !!aka("cluster") := c("matched", "unmatched"),
    !!aka("xsector") := c("matched", "unmatched")
  )
  scenarios <- example_scenarios(
    !!aka("xsector") := c("matched")
  )

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
    !!aka("cluster") := c("matched1", "matched2", "unmatched"),
    !!aka("xsector") := c("matched1", "matched2", "unmatched")
  )
  scenarios <- example_scenarios(
    !!aka("xsector") := c("matched1", "matched2")
  )

  out <- sector_profile(companies, scenarios) |>
    unnest_company() |>
    distinct(risk_category, value)

  na <- pull(filter(out, is.na(risk_category)), value)
  expect_equal(na, 1 / 3)
  other <- pull(filter(out, !is.na(risk_category)), value)
  expect_equal(sort(other), c(0, 0, 2 / 3))
})

test_that("at product level case 'a', 1 product matching both `type` yields both `type` in `grouped_by`", {
  match_both <- "a"
  companies <- example_sector_companies() |> filter(clustered %in% match_both)
  scenarios <- example_sector_scenarios()

  product <- sector_profile(companies, scenarios) |> unnest_product()

  expect_equal(product$grouped_by, c("ipr_a_2050", "weo_a_2050"))
})

test_that("at company level case 'a', 1 product matching both `type` yields 1 in 'one' `value` where `risk_category` is not `NA` for both values of `grouped_by`", {
  match_both <- "a"
  companies <- example_sector_companies() |> filter(clustered %in% match_both)
  scenarios <- example_sector_scenarios()

  company <- sector_profile(companies, scenarios) |> unnest_company()

  value <- company |>
    filter(grouped_by == "ipr_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, c(0, 0, 1))

  value <- company |>
    filter(grouped_by == "weo_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, c(0, 0, 1))
})

test_that("at product level case 'b', 1 product matching no `type` is preserved and yields `NA` in `risk_category`", {
  match_none <- "b"
  companies <- example_sector_companies() |> filter(clustered %in% match_none)
  scenarios <- example_sector_scenarios()

  product <- sector_profile(companies, scenarios) |> unnest_product()

  expect_equal(product$clustered, "b")
  expect_equal(product$grouped_by, NA_character_)
})

test_that("at company level case 'b', 1 product matching no `type` yields an 'empty_company_output()'", {
  match_none <- "b"
  companies <- example_sector_companies() |> filter(clustered %in% match_none)
  scenarios <- example_sector_scenarios()

  company <- sector_profile(companies, scenarios) |> unnest_company()

  expect_equal(company, empty_company_output_from("a"))
})

test_that("at product level case 'c', 1 product matching 1 of 2 `type` of scenarios yields both types in `grouped_by` with `NA` in the `risk_category` of the unmatched `type`", {
  match_one_of_two <- "c"
  companies <- example_sector_companies() |>
    filter(clustered %in% match_one_of_two)
  scenarios <- example_sector_scenarios()

  product <- sector_profile(companies, scenarios) |> unnest_product()

  expect_equal(sort(product$grouped_by), c("ipr_a_2050", "weo_a_2050"))
  expect_false(is.na(product$risk_category[product$grouped_by == "ipr_a_2050"]))
  expect_true(is.na(product$risk_category[product$grouped_by == "weo_a_2050"]))
})

test_that("at company level case 'c', 1 product matching 1 of 2 `type` of scenarios yields: 1 in 'the' `value` where `risk_category` is `NA` for the unmatched `type`, and 1 in 'one' `value` where `risk_category` is not `NA` for the matched `type`", {
  match_one_of_two <- "c"
  companies <- example_sector_companies() |>
    filter(clustered %in% match_one_of_two)
  scenarios <- example_sector_scenarios()

  company <- sector_profile(companies, scenarios) |> unnest_company()

  value <- company |>
    filter(grouped_by == "ipr_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, c(0, 0, 1))

  value <- company |>
    filter(grouped_by == "weo_a_2050") |>
    filter(is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, 1)
})

test_that("at both levels, all cases, with two companies yields the expected result for each company", {
  companies <- bind_rows(
    example_sector_companies(!!aka("id") := "a"),
    example_sector_companies(!!aka("id") := "b")
  )
  scenarios <- example_sector_scenarios()

  result <- sector_profile(companies, scenarios)

  product <- result |> unnest_product()
  expect_equal(
    product |> filter(companies_id == "a") |> select(-companies_id),
    product |> filter(companies_id == "b") |> select(-companies_id)
  )

  company <- result |> unnest_company()
  expect_equal(
    company |> filter(companies_id == "a") |> select(-companies_id),
    company |> filter(companies_id == "b") |> select(-companies_id)
  )
})

test_that("preserves the order of companies", {
  expected_order <- c("a", "c", "b")
  companies <- example_companies(!!aka("id") := expected_order)
  scenarios <- example_scenarios()

  result <- sector_profile(companies, scenarios)

  product <- result |> unnest_product()
  expect_equal(pull(distinct(product, companies_id)), expected_order)
  company <- result |> unnest_company()
  expect_equal(pull(distinct(company, companies_id)), expected_order)
})

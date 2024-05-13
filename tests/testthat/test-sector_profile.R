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

test_that("at product level, when `companies$sector` doesn't match `scenarios$sector`, then `product$grouped_by`, `product$risk_category`, and  `product$profile_ranking` are `NA`", {
  # Based on this GoogleSheet row:
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064&range=A5:I5
  # styler: off
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
  )
  scenarios <- tribble(
    ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
    "total",     "energy",   2050,         1.0, "ipr",       "a",
  )
  # styler: on

  product <- sector_profile(companies, scenarios) |> unnest_product()

  # Tilman's expectations
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064&range=B19:D19
  expect_true(is.na(product$grouped_by))
  expect_true(is.na(product$risk_category))
  expect_true(is.na(product$profile_ranking))
})

test_that("at product level, when `companies$sector`, `companies$subsector`, and `companies$type` match the corresponding columns in `scenarios`, then  `product$grouped_by` is '<type>_<scenario>_<year>' and `product$risk_category` and `product$profile_ranking` are not `NA`", {
  # styler: off
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
  )
  # matching type, sector and subsector
  scenarios <- tribble(
    ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
    "total",     "energy",   2050,         1.0, "ipr",       "a",
  )
  # styler: on

  product <- sector_profile(companies, scenarios) |> unnest_product()

  expect_equal(product$grouped_by, "ipr_a_2050")
  expect_false(is.na(product$risk_category))
  expect_false(is.na(product$profile_ranking))
})

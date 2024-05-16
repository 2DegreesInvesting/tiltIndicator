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

test_that("at product level, given a `clustered` matching one but not a second `type` of scenario, when the `scenarios` dataset has the two types, then the second `type` and its corresponding `scenario` are still present in `grouped_by` (#739#issuecomment-1977426095)", {
  # styler: on
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr", "land use",   "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",         NA,           NA,
  )
  scenarios <- tribble(
       ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
    "land use",   "land use",   2050,         0.3, "ipr",       "i",
       "total",     "energy",   2050,         0.6, "weo",       "w",
  )
  # styler: off
  product <- sector_profile(companies, scenarios) |> unnest_product()

  expect_true("ipr_i_2050" %in% product$grouped_by)
  expect_true("weo_w_2050" %in% product$grouped_by)
})

test_that("at product level, Tilman's example yields what he expects", {
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064
  # styler: off
    companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
              "a",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
              "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr", "land use",   "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",         NA,           NA
  )
  scenarios <- tribble(
       ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
       "total",     "energy",   2050,         1.0, "ipr",       "a",
       "total",     "energy",   2050,         0.6, "weo",       "a",
    "land use",   "land use",   2050,         0.3, "ipr",       "a"
  )
  # styler: off

  # FIXME: Change for something less brittle
  product <- sector_profile(companies, scenarios) |>
    unnest_product() |>
    arrange(clustered)

  expect_snapshot(product)
})

test_that("at company level, Tilman's example yields what he expects", {
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064
  # styler: off
    companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
              "a",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
              "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr", "land use",   "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",         NA,           NA
  )
  scenarios <- tribble(
       ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
       "total",     "energy",   2050,         1.0, "ipr",       "a",
       "total",     "energy",   2050,         0.6, "weo",       "a",
    "land use",   "land use",   2050,         0.3, "ipr",       "a"
  )
  # styler: off

  company <- sector_profile(companies, scenarios) |> unnest_company()

  # FIXME: Change for something less brittle
  expect_snapshot(company)
})

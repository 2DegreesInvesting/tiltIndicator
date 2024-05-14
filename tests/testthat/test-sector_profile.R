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

test_that("at product level, an unmatched product yields `NA` in `risk_category` and `profile_ranking`", {
  companies <- example_companies(
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
    unnest_product() |>
    filter(.data[[aka("uid")]] == "unmatched")

  expect_true(is.na(out$risk_category))
  expect_true(is.na(out$profile_ranking))
})

test_that("at company level, `risk_category` always has the value `NA` (#638)", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_company()
  expect_true(anyNA(out$risk_category))
})

test_that("at company level with one company, a company with one unmatched product yields 1 row for each `risk_category`", {
  companies <- example_companies(
    !!aka("xsector") := "unmatched",
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |> unnest_company()
  expect_equal(nrow(out), 4)
})

test_that("at company level with two companies, a company with one unmatched product yields 1 row for each `risk_category`", {
  companies <- example_companies(
    !!aka("id") := c("a", "unmatched"),
    !!aka("uid") := c("a", "unmatched"),
    !!aka("xsector") := c("total", "unmatched"),
  )
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios) |>
    unnest_company() |>
    filter(.data[[aka("id")]] == "unmatched")

  expect_equal(nrow(filter(out)), 4)
})

test_that("at company level, one matched and one unmatched products yield `value = 1/2` where `risk_category = NA` and in one other `risk_category` (#657)", {
  skip("FIXME rething expected values at company level")
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
  skip("FIXME rething expected values at company level")
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

test_that("at product level, when a single product matches by `sector`, `subsector`, and `type`, then `grouped_by` has the format `<type>_<scenario>_<year>`, and `risk_category` and `profile_ranking` are not `NA`", {
  # styler: off
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
  )
  # type, sector and subsector all match
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

test_that("at product level, an unmatched `type`, `sector`, or `subsector` yields `NA` in `risk_category`, and `profile_ranking`", {
  # Relevan row in Tilman's test-data:
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064&range=A5:I5
  # styler: off
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "b",                       "any",        "any",           "any",       "ipr",     "total",    "energy",
  )

  scenarios <- tribble(
    ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
    "total",     "energy",   2050,         1.0, "ipr",       "a",
  )
  # styler: on

  # Relevant Tilman's expectations:
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064&range=B19:D19
  col <- "type"
  companies1 <- companies
  companies1[[col]] <- "unmatched"
  product <- sector_profile(companies1, scenarios) |> unnest_product()
  expect_true(is.na(product$risk_category))
  expect_true(is.na(product$profile_ranking))

  col <- "sector"
  companies1 <- companies
  companies1[[col]] <- "unmatched"
  product <- sector_profile(companies1, scenarios) |> unnest_product()
  expect_true(is.na(product$risk_category))
  expect_true(is.na(product$profile_ranking))

  col <- "subsector"
  companies1 <- companies
  companies1[[col]] <- "unmatched"
  product <- sector_profile(companies1, scenarios) |> unnest_product()
  expect_true(is.na(product$risk_category))
  expect_true(is.na(product$profile_ranking))
})

test_that("at product level, when a product matches `sector` and `subsector` for one `type`, then `groupd_by` has at least one value for every `type`", {
  # styler: off
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr", "land use",   "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",         NA,           NA
  )
  scenarios <- tribble(
       ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
    "land use",   "land use",   2050,         0.3, "ipr",       "a"
  )
  # styler: on

  product <- sector_profile(companies, scenarios) |> unnest_product()

  extract_unique_type <- function(x) {
    x |>
      strsplit("_") |>
      lapply(\(x) x[[1]]) |>
      unlist() |>
      unique()
  }

  # TODO: This expectation may become more specific based on Tilman's answer to
  # https://github.com/2DegreesInvesting/tiltIndicator/pull/739#issuecomment-2110919379
  expect_equal(extract_unique_type(product$grouped_by), c("ipr", "weo"))
})

test_that("at company level, when a single product matches by `sector`, `subsector`, and `type` then the `value` is 1 in a single `risk_category` different from `NA`", {
  # styler: off
  companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
  )
  # type, sector and subsector all match
  scenarios <- tribble(
    ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
    "total",     "energy",   2050,         1.0, "ipr",       "a",
  )
  # styler: on

  company <- sector_profile(companies, scenarios) |> unnest_company()
  values <- filter(company, !is.na(risk_category))$value
  expect_equal(sort(values), c(0, 0, 1))
})

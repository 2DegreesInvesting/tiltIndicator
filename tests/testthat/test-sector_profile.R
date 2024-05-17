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
  # styler: off
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
  # styler: on
  product <- sector_profile(companies, scenarios) |> unnest_product()

  expect_true("ipr_i_2050" %in% product$grouped_by)
  expect_true("weo_w_2050" %in% product$grouped_by)
})

# TODO: Create a constructor for Tilman's example

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
  # styler: on

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
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr",  "land use",  "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",          NA,          NA
  )
  scenarios <- tribble(
         ~sector, ~subsector, ~year, ~reductions, ~type, ~scenario,
         "total",   "energy",  2050,           1, "ipr",       "a",
         "total",   "energy",  2050,         0.6, "weo",       "a",
      "land use", "land use",  2050,         0.3, "ipr",       "a"
  )
  # styler: on

  company <- sector_profile(companies, scenarios) |> unnest_company()

  # FIXME: Change for something less brittle
  expect_snapshot(company)
})

test_that("works with Tilman's example case 'a': match both", {
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064
  # styler: off
  companies_full <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
              "a",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
              "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr",  "land use",  "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",          NA,          NA
  )
  scenarios <- tribble(
         ~sector, ~subsector, ~year, ~reductions, ~type, ~scenario,
         "total",   "energy",  2050,           1, "ipr",       "a",
         "total",   "energy",  2050,         0.6, "weo",       "a",
      "land use", "land use",  2050,         0.3, "ipr",       "a"
  )
  # styler: on

  # match both
  case <- "a"
  companies <- companies_full |> filter(clustered %in% case)
  result <- sector_profile(companies, scenarios)

  # has both types
  product <- result |> unnest_product()
  expect_equal(product$grouped_by, c("ipr_a_2050", "weo_a_2050"))
  #
  company <- sector_profile(companies, scenarios) |> unnest_company()
  value <- company |>
    filter(grouped_by == "ipr_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  # value is 1 in a risk_category different than NA
  expect_equal(value, c(0, 0, 1))
  value <- company |>
    filter(grouped_by == "weo_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  # value is 1 in a risk_category different than NA
  expect_equal(value, c(0, 0, 1))
})

test_that("works with Tilman's example case 'b': match none", {
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064
  # styler: off
  companies_full <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
              "a",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
              "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr",  "land use",  "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",          NA,          NA
  )
  scenarios <- tribble(
         ~sector, ~subsector, ~year, ~reductions, ~type, ~scenario,
         "total",   "energy",  2050,           1, "ipr",       "a",
         "total",   "energy",  2050,         0.6, "weo",       "a",
      "land use", "land use",  2050,         0.3, "ipr",       "a"
  )
  # styler: on

  # match none
  case <- "b"
  companies <- companies_full |> filter(clustered %in% case)
  result <- sector_profile(companies, scenarios)

  # has unmatched product and grouped_by is NA
  product <- result |> unnest_product()
  expect_equal(product$clustered, "b")
  expect_equal(product$grouped_by, NA_character_)
  # empty output for `company` "a"
  company <- sector_profile(companies, scenarios) |> unnest_company()
  expect_equal(company, empty_company_output_from("a"))
})

test_that("at product level, 1 product matching 1 of 2 `type` of scenarios yields both types in `grouped_by` with `NA` in the `risk_category` of the unmatched `type`", {
  matches_one_of_two_types <- "c"
  companies <- example_sector_companies() |>
    filter(clustered %in% matches_one_of_two_types)
  scenarios <- example_sector_scenarios()
  result <- sector_profile(companies, scenarios)


  product <- result |> unnest_product()
  # has both types
  expect_equal(sort(product$grouped_by), c("ipr_a_2050", "weo_a_2050"))
  # the matched type has a non-missing risk_category
  expect_false(is.na(product$risk_category[product$grouped_by == "ipr_a_2050"]))
  # the unmatched type has a missing risk_category
  expect_true(is.na(product$risk_category[product$grouped_by == "weo_a_2050"]))

  company <- sector_profile(companies, scenarios) |> unnest_company()
  # the matched type has value 1 where risk_category is not NA
  value <- company |>
    filter(grouped_by == "ipr_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, c(0, 0, 1))

  # the unmatched type has value 1 where risk_category is NA
  value <- company |>
    filter(grouped_by == "weo_a_2050") |>
    filter(is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, 1)
})

test_that("at both levels, with a single produce that matches one of two types of scenarios yields the expected output", {
  matches_one_of_two_types <- "c"
  companies <- example_sector_companies() |>
    filter(clustered %in% matches_one_of_two_types)
  scenarios <- example_sector_scenarios()

  result <- sector_profile(companies, scenarios)

  product <- result |> unnest_product()
  # has both types
  expect_equal(product$grouped_by, c("ipr_a_2050", "weo_a_2050"))
  # the matched type has a non-missing risk_category
  expect_false(is.na(product$risk_category[product$grouped_by == "ipr_a_2050"]))
  # the unmatched type has a missing risk_category
  expect_true(is.na(product$risk_category[product$grouped_by == "weo_a_2050"]))

  company <- sector_profile(companies, scenarios) |> unnest_company()
  # the matched type has value 1 where risk_category is not NA
  value <- company |>
    filter(grouped_by == "ipr_a_2050") |>
    filter(!is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, c(0, 0, 1))

  # the unmatched type has value 1 where risk_category is NA
  value <- company |>
    filter(grouped_by == "weo_a_2050") |>
    filter(is.na(risk_category)) |>
    pull(value) |>
    sort()
  expect_equal(value, 1)
})

test_that("at product level, Tilman's example with two companies yields what he expects", {
  # https://docs.google.com/spreadsheets/d/16u9WNtVY-yDsq6kHANK3dyYGXTbNQ_Bn/edit#gid=156243064
  # styler: off
    companies <- tribble(
    ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector, ~tilt_subsector,       ~type,     ~sector,  ~subsector,
              "a",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
              "a",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
              "a",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
              "a",        "c",                 "unmatched",          "c",             "c",       "ipr", "land use",   "land use",
              "a",        "c",                 "unmatched",          "c",             "c",       "weo",         NA,           NA,

              "b",        "a",                         "a",          "a",             "a",       "ipr",     "total",    "energy",
              "b",        "a",                         "a",          "a",             "a",       "weo",     "total",    "energy",
              "b",        "b",                 "unmatched",  "unmatched",     "unmatched", "unmatched", "unmatched", "unmatched",
              "b",        "c",                 "unmatched",          "c",             "c",       "ipr", "land use",   "land use",
              "b",        "c",                 "unmatched",          "c",             "c",       "weo",         NA,           NA
  )
  scenarios <- tribble(
       ~sector,   ~subsector,  ~year, ~reductions, ~type, ~scenario,
       "total",     "energy",   2050,         1.0, "ipr",       "a",
       "total",     "energy",   2050,         0.6, "weo",       "a",
    "land use",   "land use",   2050,         0.3, "ipr",       "a"
  )
  # styler: on

  product <- sector_profile(companies, scenarios) |> unnest_product()
  expect_equal(
    product |> filter(companies_id == "a") |> select(-companies_id),
    product |> filter(companies_id == "b") |> select(-companies_id)
  )

  company <- sector_profile(companies, scenarios) |> unnest_company()
  expect_equal(
    company |> filter(companies_id == "a") |> select(-companies_id),
    company |> filter(companies_id == "b") |> select(-companies_id)
  )
})

test_that("the order of companies is preserved", {
  expected_order <- c("a", "c", "b")

  companies <- example_companies(!!aka("id") := expected_order)
  scenarios <- example_scenarios()

  result <- sector_profile(companies, scenarios)

  out <- result |> unnest_product()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
  out <- result |> unnest_company()
  expect_equal(pull(distinct(out, companies_id)), expected_order)
})

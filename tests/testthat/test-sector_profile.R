test_that("wraps the output at product and company levels", {
  companies <- example_companies()
  scenarios <- example_scenarios()

  out <- sector_profile(companies, scenarios)

  product <- unnest_product(out)
  expect_equal(product, sector_profile_at_product_level(companies, scenarios))

  company <- unnest_company(out)
  expected <- any_at_company_level(product)
  expect_equal(
    arrange(company, companies_id, grouped_by),
    arrange(expected, companies_id, grouped_by)
  )
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

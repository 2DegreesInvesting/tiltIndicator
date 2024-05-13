test_that("has class 'profile'", {
  product <- tibble(companies_id = 1, x = 1)
  company <- tibble(companies_id = 1, x = 1)
  out <- tilt_profile(nest_levels(product, company))

  expect_s3_class(out, "tilt_profile")
  expect_true(is_tilt_profile(out))
})

test_that("subsetting rows still yields an object of class 'profile'", {
  product <- tibble(companies_id = 1:2, x = 1)
  company <- tibble(companies_id = 1:2, x = 1)
  out <- tilt_profile(nest_levels(product, company))

  expect_s3_class(out, "tilt_profile")
  expect_s3_class(out[1, ], "tilt_profile")
  expect_s3_class(out |> subset(companies_id == 1), "tilt_profile")
  expect_s3_class(out |> dplyr::slice(1), "tilt_profile")
  expect_s3_class(out |> dplyr::filter(companies_id == 1), "tilt_profile")
})

test_that("with invalid input errors gracefully", {
  expect_error(
    tilt_profile("bad"),
    class = "validate_tilt_profile_top_level_names"
  )

  expect_error(
    tilt_profile(tibble(companies_id = 1, product = 1, bad = 1)),
    class = "validate_tilt_profile_top_level_names"
  )

  expect_error(
    tilt_profile(tibble(companies_id = 1, product = 1, company = 1, bad = 1)),
    class = "validate_tilt_profile_top_level_names"
  )

  expect_no_error(
    tilt_profile(tibble(companies_id = 1, product = list(1), company = list(1))),
    class = "validate_tilt_profile_type"
  )

  expect_error(
    tilt_profile(tibble(companies_id = 1, product = list(1), company = 1)),
    class = "validate_tilt_profile_type"
  )

  expect_error(
    tilt_profile(tibble(companies_id = 1, product = 1, company = list(1))),
    class = "validate_tilt_profile_type"
  )
})

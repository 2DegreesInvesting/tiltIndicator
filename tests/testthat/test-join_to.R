test_that("with a tilt_profile works at both levels", {
  product <- tibble(companies_id = 1:3, x = 1:3)
  company <- tibble(companies_id = 1:3, x = 1)
  result <- tilt_profile(nest_levels(product, company))
  summary <- summarise(product, mean = mean(x), .by = "x")

  out_product1 <- join_to(summary, unnest_product(result))
  out_product2 <- unnest_product(join_to(summary, result))
  expect_equal(out_product1, out_product2)

  out_company1 <- join_to(summary, unnest_company(result))
  out_company2 <- unnest_company(join_to(summary, result))
  expect_equal(out_product1, out_product2)
})

test_that("with a tilt_profile yields a tilt_profile", {
  product <- tibble(companies_id = 1, x = 1)
  company <- tibble(companies_id = 1, x = 1)
  result <- tilt_profile(nest_levels(product, company))
  summary <- summarise(product, mean = mean(x), .by = "x")

  out <- join_to(summary, result)

  expect_s3_class(out, "tilt_profile")
})

test_that("without shared columns yields `y` with a warning", {
  data <- tibble(companies_id = 1, x = 1)
  summary <- summarise(data, mean = mean(x))

  expect_warning(out <- join_to(summary, data))

  expect_equal(out, data)
})

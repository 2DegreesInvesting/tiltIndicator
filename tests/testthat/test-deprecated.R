test_that("xctr_at_product_level() throws a deprecation warning", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  expect_warning(xctr_at_product_level(companies, inputs), "deprecated")
})

test_that("xctr_at_company_level() throws a deprecation warning", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  product <- suppressWarnings(xctr_at_product_level(companies, inputs))
  expect_warning(xctr_at_company_level(product), "deprecated")
})

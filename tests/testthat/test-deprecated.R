test_that("`companies` throws a deprecation warning", {
  expect_warning(companies, "deprecated.*use.*tiltToyData")
})

test_that("`products` throws a deprecation warning", {
  expect_warning(products, "deprecated.*use.*tiltToyData")
})

test_that("`inputs` throws a deprecation warning", {
  expect_warning(inputs, "deprecated.*use.*tiltToyData")
})

test_that("`pstr_companies` throws a deprecation warning", {
  expect_warning(pstr_companies, "deprecated.*use.*tiltToyData")
})

test_that("`istr_companies` throws a deprecation warning", {
  expect_warning(istr_companies, "deprecated.*use.*tiltToyData")
})

test_that("istr_at_product_level() throws a deprecation warning", {
  companies <- slice(istr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)
  expect_warning(istr_at_product_level(companies, scenarios, inputs), "deprecated")
})

test_that("pstr_at_product_level() throws a deprecation warning", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  expect_warning(pstr_at_product_level(companies, scenarios), "deprecated")
})

test_that("xctr_at_product_level() throws a deprecation warning", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  expect_warning(xctr_at_product_level(companies, inputs), "deprecated")
})

test_that("istr_at_company_level() throws a deprecation warning", {
  companies <- slice(istr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)
  product <- suppressWarnings(istr_at_product_level(companies, scenarios, inputs))
  expect_warning(istr_at_company_level(product), "deprecated")
})

test_that("pstr_at_company_level() throws a deprecation warning", {
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  product <- suppressWarnings(pstr_at_product_level(companies, scenarios))
  expect_warning(pstr_at_company_level(product), "deprecated")
})

test_that("xctr_at_company_level() throws a deprecation warning", {
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  product <- suppressWarnings(xctr_at_product_level(companies, inputs))
  expect_warning(xctr_at_company_level(product), "deprecated")
})

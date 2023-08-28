test_that("pstr() throws a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  expect_warning(pstr(companies, scenarios), "deprecated")
})

test_that("istr() throws a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()
  expect_warning(istr(companies, scenarios, inputs), "deprecated")
})

test_that("xctr() throws a deprecation warning", {
  companies <- example_companies()
  products <- example_products()
  expect_warning(xctr(companies, products), "deprecated")
})

test_that("istr_at_product_level() throws a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()
  expect_warning(istr_at_product_level(companies, scenarios, inputs), "deprecated")
})

test_that("pstr_at_product_level() throws a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  expect_warning(pstr_at_product_level(companies, scenarios), "deprecated")
})

test_that("xctr_at_product_level() throws a deprecation warning", {
  companies <- example_companies()
  inputs <- read_test_csv(toy_emissions_profile_upstream_products())
  expect_warning(xctr_at_product_level(companies, inputs), "deprecated")
})

test_that("istr_at_company_level() throws a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  inputs <- example_inputs()
  product <- suppressWarnings(istr_at_product_level(companies, scenarios, inputs))
  expect_warning(istr_at_company_level(product), "deprecated")
})

test_that("pstr_at_company_level() throws a deprecation warning", {
  companies <- example_companies()
  scenarios <- example_scenarios()
  product <- suppressWarnings(pstr_at_product_level(companies, scenarios))
  expect_warning(pstr_at_company_level(product), "deprecated")
})

test_that("xctr_at_company_level() throws a deprecation warning", {
  companies <- example_companies()
  inputs <- read_test_csv(toy_emissions_profile_upstream_products())
  product <- suppressWarnings(xctr_at_product_level(companies, inputs))
  expect_warning(xctr_at_company_level(product), "deprecated")
})

test_that("xstr_pivot_type_sector_subsector() throws a deprecation warning", {
  raw_companies <- read_test_csv(extdata_path("raw_sector_profile_companies.csv"))
  expect_warning(xstr_pivot_type_sector_subsector(raw_companies), "deprecated")
})

test_that("xstr_prepare_scenario() throws a deprecation warning", {
  raw_weo <- read_test_csv(extdata_path("raw_sector_profile_any_weo_targets.csv"))
  raw_ipr <- read_test_csv(extdata_path("raw_sector_profile_any_ipr_targets.csv"))
  raw_scenarios <- list(weo = raw_weo, ipr = raw_ipr)
  expect_warning(xstr_prepare_scenario(raw_scenarios), "deprecated")
})

test_that("xstr_prune_companies() throws a deprecation warning", {
  companies <- example_companies()
  expect_warning(xstr_prune_companies(companies), "deprecated")
})

test_that("xstr_polish_output_at_company_level() throws a deprecation warning", {
  result <- tibble(
    companies_id = "a",
    grouped_by = "ipr_some thing_2020",
    risk_category = "high",
    value = 0
  )
  expect_warning(xstr_polish_output_at_company_level(result), "deprecated")
})

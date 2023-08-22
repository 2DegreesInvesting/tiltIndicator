test_that("pstr() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_sector_profile_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios())
  expect_warning(pstr(companies, scenarios), "deprecated")
})

test_that("istr() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_sector_profile_upstream_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios())
  inputs <- read_test_csv(toy_sector_profile_upstream_products())
  expect_warning(istr(companies, scenarios, inputs), "deprecated")
})

test_that("xctr() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  products <- read_test_csv(toy_emissions_profile_products())
  expect_warning(xctr(companies, products), "deprecated")
})

test_that("istr_at_product_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_sector_profile_upstream_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios())
  inputs <- read_test_csv(toy_sector_profile_upstream_products())
  expect_warning(istr_at_product_level(companies, scenarios, inputs), "deprecated")
})

test_that("pstr_at_product_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_sector_profile_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios())
  expect_warning(pstr_at_product_level(companies, scenarios), "deprecated")
})

test_that("xctr_at_product_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- read_test_csv(toy_emissions_profile_upstream_products())
  expect_warning(xctr_at_product_level(companies, inputs), "deprecated")
})

test_that("istr_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_sector_profile_upstream_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios())
  inputs <- read_test_csv(toy_sector_profile_upstream_products())
  product <- suppressWarnings(istr_at_product_level(companies, scenarios, inputs))
  expect_warning(istr_at_company_level(product), "deprecated")
})

test_that("pstr_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_sector_profile_companies())
  scenarios <- read_test_csv(toy_sector_profile_any_scenarios())
  product <- suppressWarnings(pstr_at_product_level(companies, scenarios))
  expect_warning(pstr_at_company_level(product), "deprecated")
})

test_that("xctr_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- read_test_csv(toy_emissions_profile_any_companies())
  inputs <- read_test_csv(toy_emissions_profile_upstream_products())
  product <- suppressWarnings(xctr_at_product_level(companies, inputs))
  expect_warning(xctr_at_company_level(product), "deprecated")
})

test_that("xstr_pivot_type_sector_subsector() throws a deprecation warning", {
  skip_if(on_rcmd())
  raw_companies <- read_test_csv(extdata_path("pstr_companies.csv"))
  expect_warning(xstr_pivot_type_sector_subsector(raw_companies), "deprecated")
})

test_that("xstr_prepare_scenario() throws a deprecation warning", {
  skip_if(on_rcmd())
  raw_weo <- read_test_csv(extdata_path("str_weo_targets.csv"))
  raw_ipr <- read_test_csv(extdata_path("str_ipr_targets.csv"))
  raw_scenarios <- list(weo = raw_weo, ipr = raw_ipr)
  expect_warning(xstr_prepare_scenario(raw_scenarios), "deprecated")
})

test_that("xstr_prune_companies() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- tibble(
    company_id = "a",
    clustered = "a",
    activity_uuid_product_uuid = "a",
    tilt_sector = "a",
  )
  expect_warning(xstr_prune_companies(companies), "deprecated")
})

test_that("xstr_polish_output_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  # styler: off
  pstr <- tribble(
    ~companies_id,           ~grouped_by, ~risk_category, ~value,
              "a", "ipr_some thing_2020",         "high",      0,
  )
  # styler: on
  expect_warning(xstr_polish_output_at_company_level(pstr), "deprecated")
})

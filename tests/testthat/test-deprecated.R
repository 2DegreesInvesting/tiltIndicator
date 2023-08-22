test_that("`companies` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(companies, "deprecated.*use.*tiltToyData")
})

test_that("`products` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(products, "deprecated.*use.*tiltToyData")
})

test_that("`inputs` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(inputs, "deprecated.*use.*tiltToyData")
})

test_that("`pstr_companies` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(pstr_companies, "deprecated.*use.*tiltToyData")
})

test_that("`istr_companies` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(istr_companies, "deprecated.*use.*tiltToyData")
})

test_that("`istr_inputs` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(istr_inputs, "deprecated.*use.*tiltToyData")
})

test_that("`xstr_scenarios` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(xstr_scenarios, "deprecated.*use.*tiltToyData")
})

test_that("istr_at_product_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- slice(istr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)
  expect_warning(istr_at_product_level(companies, scenarios, inputs), "deprecated")
})

test_that("pstr_at_product_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  expect_warning(pstr_at_product_level(companies, scenarios), "deprecated")
})

test_that("xctr_at_product_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
  expect_warning(xctr_at_product_level(companies, inputs), "deprecated")
})

test_that("istr_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- slice(istr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  inputs <- slice(istr_inputs, 1)
  product <- suppressWarnings(istr_at_product_level(companies, scenarios, inputs))
  expect_warning(istr_at_company_level(product), "deprecated")
})

test_that("pstr_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- slice(pstr_companies, 1)
  scenarios <- slice(xstr_scenarios, 1)
  product <- suppressWarnings(pstr_at_product_level(companies, scenarios))
  expect_warning(pstr_at_company_level(product), "deprecated")
})

test_that("xctr_at_company_level() throws a deprecation warning", {
  skip_if(on_rcmd())
  companies <- slice(companies, 1)
  inputs <- slice(inputs, 1)
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

test_that("xxxxxxxxxxx() throws a deprecation warning", {
  skip_if(on_rcmd())
  # styler: off
  pstr <- tribble(
    ~companies_id,           ~grouped_by, ~risk_category, ~value,
              "a", "ipr_some thing_2020",         "high",      0,
  )
  # styler: on
  expect_warning(xstr_polish_output_at_company_level(pstr), "deprecated")
})

test_that("hasn't changed", {
  out <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    istr_add_reductions(istr_weo_2022) |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(istr_companies) |>
    # FIXME:
    #   Detected an unexpected many-to-many relationship between `x` and `y`.
    # i Row 1 of `x` matches multiple rows in `y`.
    # i Row 1 of `y` matches multiple rows in `x`.
    # i If a many-to-many relationship is expected, set `relationship = "many-to-many"` to silence this warning.
    suppressWarnings() |>
    format_robust_snapshot()

  expect_snapshot(out)
})

test_that("characterize crucial columns", {
  companies <- tibble(
    companies_id = "abc",
    company_name = "abc",
    eco_sectors = "steel_metal_transformation"
  )

  ep_weo <- tibble(
    ECO_sector = "steel_metal_transformation",
    weo_product_mapper = "Total",
    weo_flow_mapper = "Iron and steel"
  )

  weo <- tibble(
    scenario = "Stated Policies Scenario",
    product = "Total",
    flow = "Road passenger light duty vehicle",
    year = 2020,
    reductions = 0
  )

  companies |>
    istr_mapping(ep_weo) |>
    istr_add_reductions(weo) |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(companies) |>
    expect_no_error()
})

test_that("outputs an id for each company and a score", {
  companies <- istr_companies |>
    slice(1) |>
    select(companies_id, company_name, eco_sectors)

  ep_weo <- tibble(
    ECO_sector = "steel_metal_transformation",
    weo_product_mapper = "Total",
    weo_flow_mapper = "Iron and steel"
  )

  weo <- tibble(
    scenario = "Stated Policies Scenario",
    product = "Total",
    flow = "Road passenger light duty vehicle",
    year = 2020,
    reductions = 0
  )

  out <- companies |>
    istr_mapping(ep_weo) |>
    istr_add_reductions(weo) |>
    istr_add_transition_risk() |>
    istr_aggregate_scores(companies)

  expect_true(hasName(out, "companies_id"))
  expect_true(hasName(out, "score_aggregated"))
})

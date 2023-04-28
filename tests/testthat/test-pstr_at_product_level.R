test_that("returns a tibble data frame", {
  companies <- slice(pstr_companies, 1)
  scenarios <- pstr_scenarios
  out <- pstr_at_product_level(companies, scenarios)
  expect_true(hasName(out, "transition_risk"))
})

test_that("added column returns acceptable values", {
  companies <- pstr_companies
  scenarios <- pstr_scenarios
  out <- pstr_at_product_level(companies, scenarios)
  valid <- c("low", "medium", "high", "no_sector")
  all_risk_categories_are_valid <- all(unique(out$transition_risk) %in% valid)
  expect_true(all_risk_categories_are_valid)
})

test_that("snapshot", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("outputs the expected columns", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_true(all(common_output_columns() %in% names(out)))
  expect_true(any(grepl("score", names(out))))
  expect_equal(names(out)[1:3], c("id", "transition_risk", "score_aggregated"))
})

test_that("the output is not grouped", {
  scenarios <- pstr_scenarios
  companies <- pstr_companies |> slice(1)
  out <- pstr(companies, scenarios)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("if a company has no products, shares are NA (#176)", {
  skip("FIXE: Bug #176?")
  companies <- mutate(slice(pstr_companies, 1), products = NA)
  scenarios <- pstr_scenarios
  out <- pstr(companies, scenarios)
  expect_equal(unique(out$score_aggregated), NA)
})



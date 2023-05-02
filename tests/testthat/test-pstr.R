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

test_that("with a 0-row `copmanies` outputs a well structured 0-row tibble", {
  out0 <- pstr(pstr_companies[0L, ], pstr_scenarios)
  expect_s3_class(out0, "tbl")
  expect_equal(nrow(out0), 0L)

  out1 <- pstr(pstr_companies[1L, ], pstr_scenarios)
  expect_s3_class(out1, "tbl")

  expect_equal(names(out0), names(out1))
})

test_that("outputs correct values for edge cases", {
  skip("FIXME: Adapt to new API")
  edge_cases <- pstr_toy_weo_2022(reductions = c(NA, 30, 30.1, 70, 70.1))
  with_reductions <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), edge_cases)
  out <- pstr_add_transition_risk(with_reductions)
  expect_equal(c("no_sector", "low", "medium", "medium", "high"), out$transition_risk)
})

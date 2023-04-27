test_that("returns a tibble data frame", {
  out <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  expect_s3_class(
    pstr_add_transition_risk(out),
    "tbl_df"
  )
})

test_that("adds one column: `transition_risk`", {
  with_reductions <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  expect_false(hasName(with_reductions, "transition_risk"))

  out <- pstr_add_transition_risk(with_reductions)
  new_columns <- setdiff(names(out), names(with_reductions))
  expect_equal(
    new_columns, "transition_risk"
  )
})

test_that("added column returns acceptable values", {
  out <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  acceptable_transition_risks <- c(
    "low",
    "medium",
    "high",
    "no_sector"
  )

  expect_true(
    all(
      pstr_add_transition_risk(out)$transition_risk %in% acceptable_transition_risks
    )
  )
})

test_that("preserves typeof() input columns", {
  with_reductions <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  out <- pstr_add_transition_risk(with_reductions)

  x <- unname(purrr::map_chr(with_reductions, typeof))
  y <- unname(purrr::map_chr(out[names(with_reductions)], typeof))
  expect_equal(x, y)
})

test_that("outputs 0-rows with an empty data frame as input", {
  with_reductions <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  out <- pstr_add_transition_risk(with_reductions[FALSE, ])
  expect_equal(nrow(out), 0L)
})

test_that("outputs correct values for edge cases", {
  edge_cases <- pstr_toy_weo_2022(reductions = c(NA, 30, 30.1, 70, 70.1))
  with_reductions <- pstr_old_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), edge_cases)
  out <- pstr_add_transition_risk(with_reductions)
  expect_equal(c("no_sector", "low", "medium", "medium", "high"), out$transition_risk)
})

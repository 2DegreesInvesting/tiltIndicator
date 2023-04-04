test_that("hasn't changed", {
  with_reductions <- pstr_companies |>
    pstr_add_reductions(pstr_ep_weo, pstr_weo_2022) |>
    # FIXME: Address warning
    suppressWarnings()
  out <- format_robust_snapshot(with_reductions)
  expect_snapshot(out)
})

test_that("throws an error when the user do not give enough parameters", {
  expect_error(pstr_add_reductions())
  expect_error(pstr_add_reductions(pstr_toy_companies()))
  expect_error(pstr_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo()))
})

test_that("throws an error when the user do not give the parameters in the right order", {
  expect_error(pstr_add_reductions(pstr_toy_ep_weo(), pstr_toy_companies(), pstr_toy_weo_2022()))
  expect_error(pstr_add_reductions(pstr_toy_weo_2022(), pstr_toy_companies(), pstr_toy_ep_weo()))
})

test_that("returns a tibble data frame", {
  expect_s3_class(
    pstr_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022()),
    "tbl_df"
  )
})

test_that("adds twelve new columns: `EP_categories_id`, `EP_group`, `weo_product_mapper`,
          `weo_flow_mapper`, `publication`, `scenario`, `region`, `category`,
          `unit`,`year`, `value`, `reductions`", {
  # TODO : Can we make this less redundant ?
  expect_false(hasName(pstr_toy_companies(), "EP_categories_id"))
  expect_false(hasName(pstr_toy_companies(), "EP_categories_id"))
  expect_false(hasName(pstr_toy_companies(), "EP_group"))
  expect_false(hasName(pstr_toy_companies(), "weo_product_mapper"))
  expect_false(hasName(pstr_toy_companies(), "weo_flow_mapper"))
  expect_false(hasName(pstr_toy_companies(), "publication"))
  expect_false(hasName(pstr_toy_companies(), "scenario"))
  expect_false(hasName(pstr_toy_companies(), "region"))
  expect_false(hasName(pstr_toy_companies(), "category"))
  expect_false(hasName(pstr_toy_companies(), "unit"))
  expect_false(hasName(pstr_toy_companies(), "year"))
  expect_false(hasName(pstr_toy_companies(), "value"))
  expect_false(hasName(pstr_toy_companies(), "reductions"))

  out <- pstr_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  new_columns <- setdiff(names(out), names(pstr_toy_companies()))
  expect_equal(
    new_columns, c(
      "EP_categories_id", "EP_group", "weo_product_mapper",
      "weo_flow_mapper", "publication", "scenario", "region",
      "category", "unit", "year", "value", "reductions"
    )
  )
})

test_that("additional columns appear in the output", {
  out <- pstr_add_reductions(pstr_toy_companies(x = 1), pstr_toy_ep_weo(y = 1), pstr_toy_weo_2022(z = 1))
  expect_true(hasName(out, "x"))
  expect_true(hasName(out, "y"))
  expect_true(hasName(out, "z"))
})

test_that("preserves typeof() input columns", {
  out <- pstr_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022())
  x <- unname(purrr::map_chr(pstr_toy_companies(), typeof))
  y <- unname(purrr::map_chr(out[names(pstr_toy_companies())], typeof))
  expect_equal(x, y)
})

test_that("outputs 0-rows with an empty data frame as input", {
  out <- pstr_add_reductions(pstr_toy_companies()[FALSE, ], pstr_toy_ep_weo(), pstr_toy_weo_2022())
  expect_equal(nrow(out), 0L)

  out_2 <- pstr_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo()[FALSE, ], pstr_toy_weo_2022())
  expect_equal(nrow(out), 0L)

  out_3 <- pstr_add_reductions(pstr_toy_companies(), pstr_toy_ep_weo(), pstr_toy_weo_2022()[FALSE, ])
  expect_equal(nrow(out), 0L)
})

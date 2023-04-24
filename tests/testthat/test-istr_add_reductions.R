test_that("hasn't changed", {
  out <- istr_companies |>
    istr_mapping(istr_ep_weo) |>
    # FIXME: This dataset is surprisingly large
    head() |>
    istr_add_reductions(istr_weo_2022) |>
    # FIXME:
    #   Detected an unexpected many-to-many relationship between `x` and `y`.
    # i Row 1 of `x` matches multiple rows in `y`.
    # i Row 1 of `y` matches multiple rows in `x`.
    # i If a many-to-many relationship is expected, set `relationship = "many-to-many"` to silence this warning.
    suppressWarnings() |>
    format_robust_snapshot()
  expect_snapshot(out)
})

test_that("characterize rows growth", {
  # Outputs 1 row per row in companies
  companies <- slice(istr_companies, 1:3)
  ep_weo <- slice(istr_ep_weo, 1)
  mapped <- istr_mapping(companies, ep_weo)
  weo <- slice(istr_weo_2022, 1)
  out <- istr_add_reductions(mapped, weo)
  expect_equal(nrow(out), 3)

  # Outputs 1 row per row in ep_weo
  companies <- slice(istr_companies, 1)
  ep_weo <- slice(istr_ep_weo, 1:3)
  mapped <- istr_mapping(companies, ep_weo)
  weo <- slice(istr_weo_2022, 1)
  out <- istr_add_reductions(mapped, weo)
  expect_equal(nrow(out), 3)

  # The number of rows in the output is independent from weo
  companies <- slice(istr_companies, 1)
  ep_weo <- slice(istr_ep_weo, 1)
  mapped <- istr_mapping(companies, ep_weo)
  #
  weo <- slice(istr_weo_2022, 1)[0, ]
  out <- istr_add_reductions(mapped, weo)
  expect_equal(nrow(out), 1)
  #
  weo <- slice(istr_weo_2022, 1:3)[0, ]
  out <- istr_add_reductions(mapped, weo)
  expect_equal(nrow(out), 1)
  #
  weo <- slice(istr_weo_2022, 1:3)[1:3, ]
  out <- istr_add_reductions(mapped, weo)
  expect_equal(nrow(out), 1)
})

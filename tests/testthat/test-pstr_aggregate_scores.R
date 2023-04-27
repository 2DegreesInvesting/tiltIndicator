test_that("outputs a result for companies without any products", {
  companies <- pstr_toy_companies("products" = NA)
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  out <- companies |>
    pstr_old_add_reductions(ep_weo, weo) |>
    pstr_add_transition_risk() |>
    pstr_at_company_level(companies)

  expect_equal(out$score_aggregated, 100)
})

test_that("outputs an id for each company and a score", {
  companies <- pstr_toy_companies("products" = NA)
  ep_weo <- pstr_toy_ep_weo()
  weo <- pstr_toy_weo_2022()

  out <- companies |>
    pstr_old_add_reductions(ep_weo, weo) |>
    pstr_add_transition_risk() |>
    pstr_at_company_level(companies)


  expect_true(hasName(out, "company_id"))
  expect_true(hasName(out, "score_aggregated"))
})

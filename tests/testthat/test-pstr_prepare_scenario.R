test_that("outputs the expected snapshot", {
  weo <- slice(pstr_new_weo_2022, 1:3)
  ipr <- slice(pstr_new_weo_2022, 1:3)
  out <- pstr_prepare_scenario(weo, ipr)
  expect_snapshot(format_robust_snapshot(out))
})

test_that("with weo twice type is only weo", {
  skip("TODO")
  weo <- slice(pstr_new_weo_2022, 1:3)
  scenarios <- list(weo = weo, weo = weo)
  out <- pstr_prepare_scenario(scenarios)
  expect_equal(unique(out$type), "weo")
})

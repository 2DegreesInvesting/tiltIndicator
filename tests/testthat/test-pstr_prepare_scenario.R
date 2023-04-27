test_that("outputs the expected snapshot", {
  weo <- slice(pstr_raw_weo_2022, 1:3)
  ipr <- slice(pstr_raw_weo_2022, 1:3)
  out <- pstr_prepare_scenario(list(weo = weo, ipr = ipr)) |>
    select(-publication, -scenario, -region, -year)

  expect_snapshot(out)
})

test_that("takes any number of scenarios", {
  weo <- slice(pstr_raw_weo_2022, 1:3)
  scenarios <- list(s1 = weo, s2 = weo, s3 = weo)
  out <- pstr_prepare_scenario(scenarios)
  expect_equal(unique(out$type), c("s1", "s2", "s3"))
})

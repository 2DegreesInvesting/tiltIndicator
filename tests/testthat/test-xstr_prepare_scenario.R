test_that("outputs the expected snapshot", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- read_csv(extdata_path("str_weo_targets.csv")) |> slice(1:3)
  ipr <- read_csv(extdata_path("str_ipr_targets.csv")) |> slice(1:3)
  scenarios <- list(weo = weo, ipr = ipr)
  out <- xstr_prepare_scenario(scenarios) |>
    select(-scenario, -region, -year)

  expect_snapshot(out)
})

test_that("takes any number of scenarios", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- read_csv(extdata_path("str_weo_targets.csv")) |> slice(1:3)
  scenarios <- list(s1 = weo, s2 = weo, s3 = weo)

  out <- xstr_prepare_scenario(scenarios)
  expect_equal(unique(out$type), c("s1", "s2", "s3"))
})

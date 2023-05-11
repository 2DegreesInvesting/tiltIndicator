test_that("outputs the expected snapshot", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- read_csv(extdata_path("pstr_weo_2022.csv")) |>
    rename(weo_sector = "weo_product", weo_subsector = "weo_flow") |>
    slice(1:3)
  ipr <- read_csv(extdata_path("pstr_ipr_2022.csv")) |> slice(1:3)
  scenarios <- list(weo = weo, ipr = ipr)
  out <- pstr_prepare_scenario(scenarios) |>
    select(-scenario, -region, -year)

  expect_snapshot(out)
})

test_that("takes any number of scenarios", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- read_csv(extdata_path("pstr_weo_2022.csv")) |>
    rename(weo_sector = "weo_product", weo_subsector = "weo_flow") |>
    slice(1:3)
  scenarios <- list(s1 = weo, s2 = weo, s3 = weo)

  out <- pstr_prepare_scenario(scenarios)
  expect_equal(unique(out$type), c("s1", "s2", "s3"))
})

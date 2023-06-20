test_that("takes any number of scenarios", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- read_csv(extdata_path("str_weo_targets.csv"))
  s1 <- setNames(slice(weo, 1), gsub("weo_", "s1_", names(weo)))
  s2 <- setNames(slice(weo, 2), gsub("weo_", "s2_", names(weo)))
  s3 <- setNames(slice(weo, 3), gsub("weo_", "s3_", names(weo)))
  scenarios <- list(s1 = s1, s2 = s2, s3 = s3)

  out <- xstr_prepare_scenario(scenarios)
  expect_equal(unique(out$type), c("s1", "s2", "s3"))
})

test_that("with duplicated scenario+year+sector+subsector errors gracefully (#391)", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- slice(read_csv(extdata_path("str_weo_targets.csv")), 1)
  duplicated <- mutate(bind_rows(weo, weo), co2_reductions = 1:2)
  expect_error(
    xstr_prepare_scenario(list(weo = duplicated)),
    "must be unique.*sector"
  )
})

test_that("returns visibly", {
  withr::local_options(list(readr.show_col_types = FALSE))

  weo <- slice(read_csv(extdata_path("str_weo_targets.csv")), 1)
  expect_visible(xstr_prepare_scenario(list(weo = weo)))
})

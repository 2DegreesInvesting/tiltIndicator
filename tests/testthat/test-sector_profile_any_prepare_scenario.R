test_that("takes any number of scenarios", {
  weo <- read_test_csv(extdata_path("raw_sector_profile_any_weo_targets.csv"), n_max = Inf)
  s1 <- setNames(slice(weo, 1), gsub("weo_", "s1_", names(weo)))
  s2 <- setNames(slice(weo, 2), gsub("weo_", "s2_", names(weo)))
  s3 <- setNames(slice(weo, 3), gsub("weo_", "s3_", names(weo)))
  scenarios <- list(s1 = s1, s2 = s2, s3 = s3)

  out <- sector_profile_any_prepare_scenario(scenarios)
  expect_equal(unique(out$type), c("s1", "s2", "s3"))
})

test_that("with duplicated scenario+year+sector+subsector errors gracefully (#391)", {
  weo <- read_test_csv(extdata_path("raw_sector_profile_any_weo_targets.csv"))
  duplicated <- mutate(bind_rows(weo, weo), co2_reductions = 1:2)
  expect_error(
    sector_profile_any_prepare_scenario(list(weo = duplicated)),
    "must be unique.*sector"
  )

  expect_snapshot_error(sector_profile_any_prepare_scenario(list(weo = duplicated)))
})

test_that("returns visibly", {
  weo <- read_test_csv(extdata_path("raw_sector_profile_any_weo_targets.csv"))
  expect_visible(sector_profile_any_prepare_scenario(list(weo = weo)))
})

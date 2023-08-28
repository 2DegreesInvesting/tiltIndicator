test_that("takes any number of scenarios", {
  weo <- bind_rows(example_raw_weo(), example_raw_weo())
  s1 <- set_names(slice(weo, 1), gsub("weo_", "s1_", names(weo)))
  s2 <- set_names(slice(weo, 2), gsub("weo_", "s2_", names(weo)))
  s3 <- set_names(slice(weo, 3), gsub("weo_", "s3_", names(weo)))
  scenarios <- list(s1 = s1, s2 = s2, s3 = s3)

  out <- sector_profile_any_prepare_scenario(scenarios)
  expect_equal(unique(out$type), c("s1", "s2", "s3"))
})

test_that("with duplicated scenario+year+sector+subsector errors gracefully (#391)", {
  weo <- slice(example_raw_weo(), 1L)
  duplicated <- mutate(bind_rows(weo, weo), co2_reductions = 1:2)
  expect_error(
    sector_profile_any_prepare_scenario(list(weo = duplicated)),
    "must be unique.*sector"
  )

  expect_snapshot_error(sector_profile_any_prepare_scenario(list(weo = duplicated)))
})

test_that("returns visibly", {
  raw_weo <- example_raw_weo()
  expect_visible(sector_profile_any_prepare_scenario(list(weo = raw_weo)))
})

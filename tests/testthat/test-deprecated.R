test_that("emissions_profile_any_compute_profile_ranking() is deprecated", {
  co2 <- example_products()
  expect_snapshot(
    expect_equal(
      epa_compute_profile_ranking(co2),
      emissions_profile_any_compute_profile_ranking(co2)
    )
  )
})

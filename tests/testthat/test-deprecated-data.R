# These tests must be in their own file. Else their order in a file can trigger
# unexpected failures

test_that("`companies` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(companies, "deprecated.*use.*tiltToyData")
})

test_that("`products` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(products, "deprecated.*use.*tiltToyData")
})

test_that("`inputs` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(inputs, "deprecated.*use.*tiltToyData")
})

test_that("`pstr_companies` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(pstr_companies, "deprecated.*use.*tiltToyData")
})

test_that("`istr_companies` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(istr_companies, "deprecated.*use.*tiltToyData")
})

test_that("`istr_inputs` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(istr_inputs, "deprecated.*use.*tiltToyData")
})

test_that("`xstr_scenarios` throws a deprecation warning", {
  skip_if(on_rcmd())
  expect_warning(xstr_scenarios, "deprecated.*use.*tiltToyData")
})

test_that("emissions_profile_any_compute_profile_ranking() is deprecated", {
  co2 <- example_products()
  expect_snapshot(
    expect_equal(
      epa_compute_profile_ranking(co2),
      emissions_profile_any_compute_profile_ranking(co2)
    )
  )
})

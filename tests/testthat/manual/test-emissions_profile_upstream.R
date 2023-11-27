test_that("integrates with tiltIndicatorAfter", {
  local_options(readr.show_col_types = FALSE)
  withr::local_package("tiltIndicatorAfter")
  small_matches_mapper <- head(matches_mapper, 100)

  companies <- read_csv(toy_emissions_profile_any_companies())
  co2 <- read_csv(toy_emissions_profile_upstream_products())
  output <- emissions_profile_upstream(companies, co2)

  extra_cols_pattern <- c("rowid", "isic", "sector")
  # FIXME: Handle this inside the new interface
  .co2 <- tibble::rowid_to_column(co2, "co2_rowid")
  product <- unnest_product(output) |>
    left_join(select(.co2, matches(extra_cols_pattern)), by = "co2_rowid")

  expect_no_error(
    prepare_ictr_product(
      product |> head(3),
      ep_companies |> head(3),
      ecoinvent_activities |> head(3),
      small_matches_mapper |> head(3),
      ecoinvent_inputs |> head(3),
      isic_tilt_mapper |> head(3)
    )
  )
})

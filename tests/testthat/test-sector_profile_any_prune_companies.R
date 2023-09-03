test_that("keeps the expected rows only", {
  companies <- example_companies(
    row_number = 1:7,
    !!aka("cluster") := c("b1", rep(NA, 4), "b6", "b7"),
    !!aka("uid") := c("c1", rep(NA, 4), "c6", NA),
    !!aka("tsector") := c(rep("x", 3), "y", "y", "z", "z")
  ) |>
    select(1:5)

  # Drop 2: Lacks product info and sector info is duplicated
  # Drop 3: Lacks product info and sector info is duplicated
  # Drop 5: Lacks product info and sector info is duplicated
  out <- sector_profile_any_prune_companies(companies)
  # Keep 1: Has product info
  # Keep 4: Lacks product info but sector info is unique
  # Keep 6: Has product info
  # Keep 7: Has product info
  expect_equal(out$row_number, c(1, 4, 6, 7))
})

test_that("preserves row order", {
  special_order <- c("z", "y", "x")
  companies <- example_companies(!!aka("tsector") := special_order)
  out <- sector_profile_any_prune_companies(companies)
  expect_equal(out$tilt_sector, c(companies$tilt_sector))
})

test_that("with example xstr `companies` outputs the same input columns", {
  companies <- example_companies()
  out <- sector_profile_any_prune_companies(companies)
  expect_equal(names(out), names(companies))

  companies <- example_companies()
  out <- sector_profile_any_prune_companies(companies)
  expect_equal(names(out), names(companies))
})

test_that("without crucial columns errors gracefully", {
  companies <- example_companies()

  crucial <- aka("id")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_any_prune_companies(bad), crucial)

  crucial <- aka("cluster")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_any_prune_companies(bad), crucial)

  crucial <- aka("uid")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_any_prune_companies(bad), crucial)

  crucial <- aka("tsector")
  bad <- select(companies, -all_of(crucial))
  expect_error(sector_profile_any_prune_companies(bad), crucial)
})

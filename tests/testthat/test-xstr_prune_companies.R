test_that("keeps the expected rows only", {
   # styler: off
  companies <- tibble::tribble(
   ~row_id, ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector,
   # Keep: Has product info
        1,           "a",       "b1",                        "c1",          "x",
   # Drop: Lacks product info and sector info is duplicated
        2,           "a",         NA,                          NA,          "x",
   # Drop: Lacks product info and sector info is duplicated
        3,           "a",         NA,                          NA,          "x",
   # Keep: Lacks product info but sector info is unique
        4,           "a",         NA,                          NA,          "y",
   # Drop: Lacks product info and sector info is duplicated
        5,           "a",         NA,                          NA,          "y",
   # Keep: Has product info
        6,           "a",       "b6",                        "c6",          "z",
   # Keep: Has product info
        7,           "a",       "b7",                          NA,          "z",
  )
  # styler: on

  out <- xstr_prune_companies(companies)
  expect_equal(out$row_id, c(1, 4, 6, 7))
})

test_that("preserves row order", {
   # styler: off
  companies <- tibble::tribble(
   ~row_id, ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector,
        1,          "a1",       "b1",                        "c1",          "z",
        1,          "a1",       "b1",                        "c1",          "y",
        1,          "a1",       "b1",                        "c1",          "x",
  )
  # styler: on
  out <- xstr_prune_companies(companies)
  expect_equal(out$tilt_sector, c(companies$tilt_sector))
})

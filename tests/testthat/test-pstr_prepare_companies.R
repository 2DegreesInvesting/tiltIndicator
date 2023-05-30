# TODO: Paarameter `col_types = cols(isic_4digit = col_character())` is missing
test_that("snapshot", {
  withr::local_options(list(readr.show_col_types = FALSE))
  companies <- slice(read_csv(extdata_path("pstr_companies.csv")), 1)
  out <- xstr_pivot_type_sector_subsector(companies)
  expect_snapshot(format_robust_snapshot(out))
})

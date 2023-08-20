test_that("snapshot", {
  local_options(list(readr.show_col_types = FALSE, width = 1000))
  companies <- read_csv(extdata_path("pstr_companies.csv"), n_max = 1)
  out <- xstr_pivot_type_sector_subsector(companies)
  expect_snapshot(as.data.frame(out))
})

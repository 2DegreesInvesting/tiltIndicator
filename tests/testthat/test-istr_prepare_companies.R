test_that("snapshot", {
  local_options(list(readr.show_col_types = FALSE, width = 1000))
  companies <- read_csv(extdata_path("istr_companies.csv"), n_max = 1)
  expect_snapshot(as.data.frame(companies))
})

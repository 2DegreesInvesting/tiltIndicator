#' Format data to print robust snapshots
#'
#' Prints each column separately, one under the other. This avoids differences
#' caused by the width of the screen while preserving a format that is easy
#' to compare when a real difference happens.
#'
#' @param data A data frame or named list in general
#' @examples
#' format_robust_snapshot(BOD)
#' @noRd
format_robust_snapshot <- function(data) {
  row.names(data) <- NULL
  lapply(names(data), function(x) as.data.frame(data)[x])
}

on_rcmd <- function() {
  nzchar(Sys.getenv("R_CMD"))
}

read_test_csv <- function(file, ..., show_col_types = FALSE, n_max = 1) {
  read_csv(file, show_col_types = show_col_types, n_max = n_max)
}

example_emissions_profile <- function() {
  companies <- example_companies()
  co2 <- example_products()
  emissions_profile(companies, co2)
}

example_emissions_profile_upstream <- function() {
  companies <- example_companies()
  co2 <- example_inputs()
  emissions_profile_upstream(companies, co2)
}

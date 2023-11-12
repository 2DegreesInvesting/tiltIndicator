#' Add values to categorize
#'
#' @param data A "co2-like" data frame -- i.e. containing products or
#'   upstream-products (a.k.a. inputs).
#'
#' @family pre-processing helpers
#'
#' @return The input data frame with the additional columns `grouped_by` and
#'   `values_to_categorize` and one row per benchmark per company.
#'
#' @export
#'
#' @examples
#' library(tiltToyData)
#' library(readr, warn.conflicts = FALSE)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_emissions_profile_any_companies())
#'
#' products <- read_csv(toy_emissions_profile_products())
#' products |> emissions_profile_any_add_values_to_categorize()
#'
#' inputs <- read_csv(toy_emissions_profile_upstream_products())
#' inputs |> emissions_profile_any_add_values_to_categorize()
emissions_profile_any_add_values_to_categorize <- function(data) {
  crucial <- c(aka("tsector"), aka("xunit"), aka("isic"), aka("co2footprint"))
  walk(crucial, \(pattern) check_matches_name(data, pattern))

  benchmarks <- set_names(epa_benchmarks(data), flat_benchmarks(data))
  map_df(benchmarks, ~ add_rank(data, .x), .id = "grouped_by")
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

epa_benchmarks <- function(data) {
  list(
    "all",
    extract_name(data, aka("isic")),
    extract_name(data, aka("tsector")),
    extract_name(data, aka("xunit")),
    c(extract_name(data, aka("xunit")), extract_name(data, aka("isic"))),
    c(extract_name(data, aka("xunit")), extract_name(data, aka("tsector")))
  )
}

flat_benchmarks <- function(data) {
  map_chr(epa_benchmarks(data), ~ paste(.x, collapse = "_"))
}

add_rank <- function(data, .by) {
  if (identical(.by, "all")) .by <- NULL
  mutate(
    data,
    values_to_categorize = rank_proportion(.data[[extract_name(data, aka("co2footprint"))]]),
    .by = all_of(.by)
  )
}

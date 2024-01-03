#' Add values to categorize
#'
#' @param data A "co2-like" data frame -- i.e. containing products or
#'   upstream-products (a.k.a. inputs).
#'
#' @family pre-processing helpers
#'
#' @return The input data frame with the additional columns `grouped_by` and
#'   `profile_ranking` and one row per benchmark per company.
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
#' products |> emissions_profile_any_compute_profile_ranking()
#'
#' inputs <- read_csv(toy_emissions_profile_upstream_products())
#' inputs |> emissions_profile_any_compute_profile_ranking()
emissions_profile_any_compute_profile_ranking <- function(data) {
  check_emissions_profile_any_compute_profile_ranking(data)

  benchmarks <- set_names(epa_benchmarks(data), flat_benchmarks(data))
  out <- map_df(benchmarks, ~ add_rank(data, .x), .id = "grouped_by")

  related_cols <- c("grouped_by", "profile_ranking")
  relocate(out, all_of(related_cols)) |>
    exclude_special_cases()
}

check_emissions_profile_any_compute_profile_ranking <- function(data) {
  crucial <- c(aka("tsector"), aka("xunit"), aka("isic"), aka("co2footprint"))
  walk(crucial, \(pattern) check_matches_name(data, pattern))
}

rank_proportion <- function(x) {
  dense_rank(x) / length(unique(x))
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
    profile_ranking = rank_proportion(.data[[extract_name(data, aka("co2footprint"))]]),
    .by = all_of(.by)
  )
}

exclude_special_cases <- function(data) {
  data |>
    mutate(profile_ranking = case_when(
      short_isic_should_be_na(data) ~ NA,
      missing_isic_should_be_na(data) ~ NA,
      missing_tsector_should_be_na(data) ~ NA,
      .default = profile_ranking
    ))
}

short_isic_should_be_na <- function(data) {
  isic <- get_column(data, aka("isic"))
  two_quotes_plus_2_or_3_digits <- c(4, 5)
  short_isic <- str_length(isic) %in% two_quotes_plus_2_or_3_digits
  short_isic & is_benchmark_to_exclude(data, aka("isic"))
}

is_benchmark_to_exclude <- function(data, pattern) {
  col_name <- extract_name(data, pattern)
  data$grouped_by %in% c(col_name, paste0("unit_", col_name))
}

missing_isic_should_be_na <- function(data) {
  pattern <- aka("isic")
  is.na(get_column(data, pattern)) & is_benchmark_to_exclude(data, pattern)
}

missing_tsector_should_be_na <- function(data) {
  pattern <- aka("tsector")
  is.na(get_column(data, pattern)) & is_benchmark_to_exclude(data, pattern)
}

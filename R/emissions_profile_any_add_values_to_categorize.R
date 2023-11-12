emissions_profile_any_add_values_to_categorize <- function(data) {
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

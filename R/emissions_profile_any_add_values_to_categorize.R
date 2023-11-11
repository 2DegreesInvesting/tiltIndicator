emissions_profile_any_add_values_to_categorize <- function(data) {
  benchmarks <- set_names(epa_benchmarks(), flat_benchmarks())
  map_df(benchmarks, ~ add_rank(data, .x), .id = "grouped_by")
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

epa_benchmarks <- function() {
  list(
    "all",
    "isic_sec",
    "tilt_sec",
    "unit",
    c("unit", "isic_sec"),
    c("unit", "tilt_sec")
  )
}

flat_benchmarks <- function() {
  map_chr(epa_benchmarks(), ~ paste(.x, collapse = "_"))
}

add_rank <- function(data, .by) {
  if (identical(.by, "all")) .by <- NULL
  mutate(
    data,
    values_to_categorize = rank_proportion(.data[[find_co2_footprint(data)]]),
    .by = all_of(.by)
  )
}

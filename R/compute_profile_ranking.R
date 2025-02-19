#' Compute profile ranking
#'
#' @name compute_profile_ranking
#' @keywords internal
NULL

#' @rdname compute_profile_ranking
#' @export
#' @keywords internal
spa_compute_profile_ranking <- function(data, scenarios) {
  left_join(
    data, scenarios,
    by = c(aka("scenario_type"), aka("xsector"), aka("xsubsector")),
    relationship = "many-to-many"
  )
}

#' @rdname compute_profile_ranking
#' @export
#' @keywords internal
epa_compute_profile_ranking <- function(data) {
  check_epa_compute_profile_ranking(data)

  excluded_uuids <- pull_uuids_with_unique_uuid_count_unit_isic_1(data)

  exclude <- short_isic(data) |
    is.na(get_column(data, aka("isic"))) |
    is.na(get_column(data, aka("tsubsector"))) |
    is.na(get_column(data, aka("xunit")))

  list(!exclude, exclude) |>
    map(\(x) filter(data, x)) |>
    map_df(\(data) epa_compute_profile_ranking_impl(data)) |>
    assign_na_to_profile_ranking_in_special_cases(excluded_uuids)
}

epa_compute_profile_ranking_impl <- function(data) {
  benchmarks <- set_names(epa_benchmarks(data), flat_benchmarks(data))
  out <- map_df(benchmarks, \(x) add_rank(data, x), .id = "grouped_by")

  related_cols <- c("grouped_by", "profile_ranking")
  relocate(out, all_of(related_cols))
}

check_epa_compute_profile_ranking <- function(data) {
  crucial <- c(aka("tsubsector"), aka("xunit"), aka("isic"), aka("co2footprint"))
  walk(crucial, \(pattern) check_matches_name(data, pattern))
}

rank_proportion <- function(x) {
  dense_rank(x) / length(unique(x))
}

epa_benchmarks <- function(data) {
  list(
    "all",
    extract_name(data, aka("isic")),
    extract_name(data, aka("tsubsector")),
    extract_name(data, aka("xunit")),
    c(extract_name(data, aka("xunit")), extract_name(data, aka("isic"))),
    c(extract_name(data, aka("xunit")), extract_name(data, aka("tsubsector")))
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

assign_na_to_profile_ranking_in_special_cases <- function(data, excluded_uuids) {
  data |>
    mutate(profile_ranking = case_when(
      data |> should_be_na_when_isic_has_2_or_3_digits() ~ NA,
      data |> should_be_na_when_missing(aka("isic")) ~ NA,
      data |> should_be_na_when_missing(aka("tsubsector")) ~ NA,
      data |> should_be_na_when_missing(aka("xunit")) ~ NA,
      data |> should_be_na_when_unique_uuids_is_1_for_unit_isic(excluded_uuids, "unit_isic_4digit") ~ NA,
      .default = .data$profile_ranking
    ))
}

should_be_na_when_isic_has_2_or_3_digits <- function(data) {
  short_isic(data) & is_benchmark_to_exclude(data, aka("isic"))
}

short_isic <- function(data) {
  two_quotes_plus_2_or_3_digits <- c(4, 5)
  str_length(get_column(data, aka("isic"))) %in% two_quotes_plus_2_or_3_digits
}

is_benchmark_to_exclude <- function(data, pattern) {
  grepl(pattern, data$grouped_by)
}

should_be_na_when_missing <- function(data, pattern) {
  is.na(get_column(data, pattern)) & is_benchmark_to_exclude(data, pattern)
}

pull_uuids_with_unique_uuid_count_unit_isic_1 <- function(data) {
  data |>
    mutate(unique_uuid_count_unit_isic = n_distinct(.data$activity_uuid_product_uuid), .by = c("unit", "isic_4digit")) |>
    filter(.data$unique_uuid_count_unit_isic == 1) |>
    pull(activity_uuid_product_uuid) |>
    unique()
}

should_be_na_when_unique_uuids_is_1_for_unit_isic <- function(data, excluded_uuids, pattern) {
  (get_column(data, aka("uid")) %in% excluded_uuids) & is_benchmark_to_exclude(data, pattern)
}

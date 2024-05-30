#' Adds low and high thresholds for transition risk score
#'
#' @param emissions_profile_products A dataframe
#' @param all_uuids_scenario_sectors A dataframe
#' @param scenarios A dataframe
#'
#' @keywords internal
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' library(tiltToyData)
#' library(readr)
#' library(dplyr)
#' options(readr.show_col_types = FALSE)
#'
#' emissions_profile_products <- read_csv(toy_emissions_profile_products_ecoinvent())
#' all_uuids_scenario_sectors <- read_csv(toy_sector_profile_companies()) |>
#'   select(-c("companies_id", "company_name", "clustered")) |>
#'   distinct()
#' scenarios <- read_csv(toy_sector_profile_any_scenarios())
#'
#' output <- trs_low_high_thresholds_for_ecoinvent_all(
#'   emissions_profile_products,
#'   all_uuids_scenario_sectors,
#'   scenarios
#' )
#' output
trs_low_high_thresholds_for_ecoinvent_all <- function(emissions_profile_products,
                                                      all_uuids_scenario_sectors,
                                                      scenarios) {
  epa_profile_ranking <- epa_compute_profile_ranking(emissions_profile_products) |>
    prepare_profile_ranking()

  spa_reduction_targets <- spa_compute_profile_ranking(
    all_uuids_scenario_sectors,
    scenarios
  ) |>
    prepare_reduction_targets()

  dplyr::full_join(
    epa_profile_ranking,
    spa_reduction_targets,
    by = c("activity_uuid_product_uuid"),
    relationship = "many-to-many"
  ) |>
    create_tr_benchmarks_tr_score(.data$profile_ranking, .data$reductions) |>
    distinct() |>
    add_trs_thresholds(.by = "benchmark_tr_score")
}

#' Calulate `transition_risk_score` and `benchmark_tr_score` columns
#'
#' @param data Dataframe.
#' @param profile_ranking Dataframe column.
#' @param reduction_targets Dataframe column.
#' @keywords internal
#' @export
create_tr_benchmarks_tr_score <- function(data, profile_ranking, reduction_targets) {
  mutate(
    data,
    transition_risk_score = ifelse(
      is.na({{ profile_ranking }}) | is.na({{ reduction_targets }}),
      NA,
      ({{ profile_ranking }} + {{ reduction_targets }}) / 2
    ),
    benchmark_tr_score = ifelse(
      is.na({{ profile_ranking }}) | is.na({{ reduction_targets }}),
      NA,
      paste(.data$scenario_year, .data$grouped_by, sep = "_")
    )
  )
}

add_trs_thresholds <- function(data, .by) {
  mutate(data,
    trs_low_threshold = stats::quantile(.data$transition_risk_score,
      probs = c(1 / 3, 2 / 3),
      na.rm = TRUE
    )[[1]],
    trs_high_threshold = stats::quantile(.data$transition_risk_score,
      probs = c(1 / 3, 2 / 3),
      na.rm = TRUE
    )[[2]],
    .by = all_of(.by)
  )
}

prepare_reduction_targets <- function(data) {
  data |>
    select(c("activity_uuid_product_uuid", "scenario", "year", "reductions")) |>
    mutate(scenario_year = paste(.data$scenario, .data$year, sep = "_")) |>
    select(-c("scenario", "year"))
}

prepare_profile_ranking <- function(data) {
  data |>
    select(c("activity_uuid_product_uuid", "grouped_by", "profile_ranking"))
}

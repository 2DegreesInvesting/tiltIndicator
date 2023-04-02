#' Title TODO
#'
#' @param ecoinvent_co2 A [data.frame] like [pctr_ecoinvent_co2].
#' @param low_threshold A numeric value of length 1 giving ... TODO.
#' @param high_threshold A numeric value of length 1 giving ... TODO.
#'
#' @family PCTR functions
#'
#' @return A [data.frame] with columns ... TODO.
#' @export
#'
#' @examples
#' pctr_ecoinvent_co2 |>
#'   pctr_score_activities(low_threshold = 0.3, high_threshold = 0.7)
pctr_score_activities <- function(ecoinvent_co2, low_threshold, high_threshold){
  ecoinvent_co2 |>
    pctr_add_ranks() |>
    pctr_add_scores(low_threshold, high_threshold)
}

# Calculate the rank of each activity: This is done based on the activities'
# carbon footprint compared to 3 different benchmarks (all products, products
# with same unit, products with same unit and sector)
#
# rank in comparison to all products
pctr_add_ranks <- function(ecoinvent_co2) {
  # FIXME: "perc" suggests "percent" but "proportion" seems more accurate. Also
  # if the main goal is to rank, then maybe the columns should use the prefix
  # `rank_*` instead. Or maybe the goal is not to calculate the ranks, in which
  # case we need a different title?
  ecoinvent_co2 |>
    mutate(perc_all = rank(.data$co2_footprint) / length(.data$co2_footprint)) |>
    # rank in comparison to all products with same unit
    group_by(.data$unit) |>
    mutate(perc_unit = rank(.data$co2_footprint) / length(.data$co2_footprint)) %>%
    ungroup() |>
    # rank in comparison to all products with same unit and sector
    group_by(.data$unit, .data$sec) |>
    mutate(perc_unit_sec = rank(.data$co2_footprint) / length(.data$co2_footprint)) %>%
    ungroup()
}

# Assign scores to the activities: This is done based on their position within
# the distribution of co2 footprints in comparison to different benchmarks.
#
# assign scores to position within percentile distribution
# for all products
pctr_add_scores <- function(ecoinvent_ranks, low_threshold, high_threshold) {
  ecoinvent_ranks %>%
    mutate(
      score_all = case_when(
        perc_all < low_threshold ~ "low",
        perc_all >= low_threshold & perc_all < high_threshold ~ "medium",
        perc_all >= high_threshold ~ "high"
      )
    ) |>
    # for products with same unit
    mutate(
      score_unit = case_when(
        perc_unit < low_threshold ~ "low",
        perc_unit >= low_threshold & perc_unit < high_threshold ~ "medium",
        perc_unit >= low_threshold ~ "high"
      )
    ) |>
    # for products with same unit and sector
    mutate(
      score_unit_sec = case_when(
        perc_unit_sec < low_threshold ~ "low",
        perc_unit_sec >= low_threshold & perc_unit_sec < high_threshold ~ "medium",
        perc_unit_sec >= high_threshold ~ "high",
      )
    )
}

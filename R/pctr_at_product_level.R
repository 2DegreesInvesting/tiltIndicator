#' Aggregate rank and score for each activity
#'
#' @description
#' Activities will be ranked according to their carbon footprint. Activities in
#' the highest percentile (≥70%) will be classified as high transition risk
#' products. Activities in the medium percentile (between ≥30% and <70%) will be
#' classified as medium transition risk products. Activities in the lowest
#' percentile (<30%) will be classified as low transition risk products.
#'
#' Therefore, each activity will receive either a score of 'high', 'medium', or
#' 'low' based on the above mentioned classification criteria.
#'
#' @author Tilman Trompke.
#'
#' @param co2 A [data.frame] like [pctr_ecoinvent_co2].
#' @inheritParams ictr_at_product_level
#'
#' @family internal-ish functions
#'
#' @return A [data.frame].
#'
#' @export
#'
#' @examples
#' pctr_at_product_level(pctr_ecoinvent_co2)
pctr_at_product_level <- function(co2,
                                  low_threshold = 0.3,
                                  high_threshold = 0.7) {
  .by <- list(
    "all",
    "unit",
    # FIXME: Missing "sec" (#191)
    # "sec",
    c("unit", "sec")
  )
  ranked <- xctr_add_ranks(co2, x = "co2_footprint", .by)

  ranked |>
    pctr_add_scores(
      low_threshold = low_threshold,
      high_threshold = high_threshold
    )
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

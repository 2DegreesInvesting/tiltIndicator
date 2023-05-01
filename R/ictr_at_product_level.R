#' Aggregate rank and score for each input product
#'
#' @description
#' Input products will be ranked according to their footprint. Input products in
#' the highest percentile (≥70%) will be classified as high transition risk
#' input products. Input products in the medium percentile (between ≥30% and
#' <70%) will be classified as medium transition risk input products. Products
#' in the lowest percentile (<30%) will be classified as low transition risk
#' input products.
#'
#' Therefore, each input product will receive either a score of 'high',
#' 'medium', or 'low' based on the above mentioned classification criteria.
#'
#' @author Kalash Singhal.
#'
#' @param co2 A [data.frame] like [ictr_inputs].
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#'
#' @family internal-ish functions
#'
#' @return A [data.frame].
#'
#' @export
#'
#' @examples
#' ictr_at_product_level(ictr_inputs)
ictr_at_product_level <- function(co2,
                                  low_threshold = 0.3,
                                  high_threshold = 0.7) {
  co2 |>
    ictr_add_ranks() |>
    ictr_add_scores(
      low_threshold = low_threshold,
      high_threshold = high_threshold
    )
}

ictr_add_ranks <- function(inputs) {
  inputs %>%
    ## rank in comparison to all input products
    mutate(perc_all = rank(.data$input_co2) / length(.data$input_co2)) |>
    ## rank in comparison to all input products with same unit
    group_by(.data$unit) |>
    mutate(perc_unit = rank(.data$input_co2) / length(.data$input_co2)) %>%
    ungroup() |>
    ## rank in comparison to all input products with same input sector
    group_by(.data$input_sector) |>
    mutate(perc_sec = rank(.data$input_co2) / length(.data$input_co2)) %>%
    ungroup() |>
    ## rank in comparison to all input products with same unit and input sector
    group_by(.data$unit, .data$input_sector) |>
    mutate(perc_unit_sec = rank(.data$input_co2) / length(.data$input_co2)) %>%
    ungroup()
}

ictr_add_scores <- function(ecoinvent_input, low_threshold, high_threshold) {
  ## assign scores to position within percentile distribution
  ecoinvent_input %>%
    ## for all input products
    mutate(
      score_all = case_when(
        perc_all < low_threshold ~ "low",
        perc_all >= low_threshold & perc_all < high_threshold ~ "medium",
        perc_all >= high_threshold ~ "high"
      )
    ) |>
    ## for products with same unit
    mutate(
      score_unit = case_when(
        perc_unit < low_threshold ~ "low",
        perc_unit >= low_threshold & perc_unit < high_threshold ~ "medium",
        perc_unit >= low_threshold ~ "high"
      )
    ) |>
    ## for products with same sector
    mutate(
      score_sector = case_when(
        perc_sec < low_threshold ~ "low",
        perc_sec >= low_threshold & perc_sec < high_threshold ~ "medium",
        perc_sec >= low_threshold ~ "high"
      )
    ) |>
    ## for products with same unit and sector
    mutate(
      score_unit_sec = case_when(
        perc_unit_sec < low_threshold ~ "low",
        perc_unit_sec >= low_threshold & perc_unit_sec < high_threshold ~ "medium",
        perc_unit_sec >= high_threshold ~ "high",
      )
    )
}

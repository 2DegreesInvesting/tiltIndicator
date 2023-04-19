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
#' @param inputs A [data.frame] like [ictr_inputs]
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#'
#' @family ICTR functions
#'
#' @return A [data.frame] with columns:
#'   * All the columns from the `inputs` dataset.
#'   * New columns:
#'        * `perc_all`
#'        * `perc_unit`
#'        * `perc_sec`
#'        * `perc_unit_sec`
#'        * `score_all`
#'        * `score_unit`
#'        * `score_sector`
#'        * `score_unit_sec`
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' # Minimum dataset
#' crucial <- c("input_co2", "input_sector", "unit")
#' data <- ictr_inputs |>
#'   slice(1L) |>
#'   select(all_of(crucial))
#' data
#'
#' ictr_score_inputs(data) |> glimpse()
#'
#' # With fewer columns returns an error
#' data2 <- data |> select(-unit)
#' try(ictr_score_inputs(data2))
#'
#' # Additional columns are added to the output
#' data3 <- data |> mutate(new = 1)
#' ictr_score_inputs(data3) |> relocate(new)
#'
#' # You may customize thresholds
#' data4 <- ictr_inputs |>
#'   slice(1:3) |>
#'   select(all_of(crucial))
#'
#' # Default
#' ictr_score_inputs(data4) |>
#'   relocate(starts_with("score_"))
#'
#' # Custom
#' ictr_score_inputs(data4, low_threshold = 1, high_threshold = 2) |>
#'   relocate(starts_with("score_"))
ictr_score_inputs <- function(inputs,
                              low_threshold = 0.3,
                              high_threshold = 0.7) {
  inputs |>
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

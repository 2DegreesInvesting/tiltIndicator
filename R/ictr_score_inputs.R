#' TODO
#'
#' @param inputs TODO
#' @param low_threshold TODO
#' @param high_threshold TODO
#'
#' @family ICTR functions
#'
#' @return TODO
#' @export
#'
#' @examples
#' ictr_score_inputs(ictr_inputs)
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

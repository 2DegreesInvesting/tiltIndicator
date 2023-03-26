#' Title
#'
#' @param with_reductions A data frame. The output of [pstr_add_reductions()].
#'
#' @return TODO
#' @export
#'
#' @examples
#' # TODO
pstr_add_transition_risk <- function(with_reductions) {
  with_reductions |>
    mutate(
      transition_risk = case_when(
        reductions <= 30 ~ "low",
        reductions > 30 & reductions <= 70 ~ "medium",
        reductions >= 70 ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

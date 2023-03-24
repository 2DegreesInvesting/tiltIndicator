# TODO: Complete documentation
#' Title
#'
#' @param data A data frame. The ouptput of [pstr_add_reductions()].
#'
#' @return
#' @export
#'
#' @examples
#' TODO: Move to R/function-name.R
pstr_add_transition_risk <- function(data) {
  data |>
    mutate(
      transition_risk = case_when(
        reductions <= 30 ~ "low",
        reductions > 30 & reductions <= 70 ~ "medium",
        reductions >= 70 ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

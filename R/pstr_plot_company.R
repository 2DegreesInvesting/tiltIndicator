#' Title
#'
#' @param data A data frame. The output of [pstr_aggregate_scores()].
#' @param company_name TODO
#'
#' @return TODO
#' @export
#'
#' @examples
#' # TODO
pstr_plot_company <- function(data, company_name) {
  level_order <- c("low", "medium", "high")

  data |>
    filter(.data$company_name == .env$company_name) |>
    ggplot(aes(x = .data$transition_risk, y = .data$score_aggregated)) +
    scale_x_discrete(limits = level_order) +
    geom_col() +
    facet_grid(.data$company_name ~ .data$scenario + .data$year)
}


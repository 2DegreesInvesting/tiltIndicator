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
  .company_name <- company_name
  level_order <- c("low", "medium", "high")

  data |>
    filter(.data$company_name == .company_name) |>
    ggplot(aes(x = transition_risk, y = score_aggregated, fill = score_aggregated)) +
    scale_x_discrete(limits = level_order) +
    geom_col() +
    scale_fill_gradient2(midpoint = 0, low = "red", high = "blue") +
    facet_grid(company_name ~ scenario + year)
}

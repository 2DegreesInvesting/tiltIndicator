#' Plot the product sector transition risk for a company
#'
#' `pstr_plot_company()` outputs a plot on which the x-axis is the product sector
#' transition risk and the y-axis is the aggregated product score in % for
#' the company called `company_name`.
#'
#' @param data A data frame. The output of [pstr_aggregate_scores()].
#' @param company_name A string. Name of the company in the portfolio that
#' the user wants to plot.
#'
#' @return A [ggplot()].
#' @export
#'
#' @examples
#' data <- companies |>
#'   pstr_add_reductions(ep_weo, weo_2022) |>
#'   pstr_add_transition_risk() |>
#'   pstr_aggregate_scores(companies)
#'
#' data |>
#'   pstr_plot_company("Peasant Peter")
pstr_plot_company <- function(data, company_name) {
  level_order <- c("low", "medium", "high")

  data |>
    filter(.data$company_name == .env$company_name) |>
    ggplot(aes(x = .data$transition_risk, y = .data$score_aggregated)) +
    scale_x_discrete(limits = level_order) +
    geom_col() +
    facet_grid(.data$company_name ~ .data$scenario + .data$year)
}

#' Plot the product sector transition risk for a company
#'
#' @description
#' Outputs a plot on which the x-axis is the product sector
#' transition risk and the y-axis is the aggregated product score in % for
#' the company `company_name`.
#'
#' @param data A data frame. The output of [pstr_aggregate_scores()].
#' @param company_name A string. Name of the company in the portfolio that
#' the user wants to plot.
#'
#' @return A [ggplot()].
#' @export
#'
#' @examples
#'
#'library(tibble)
#'
#'data <- tibble(
#'          company_name = "a",
#'          transition_risk = c("high","low"),
#'          scenario = c("A", "B"),
#'          year = 2020,
#'          score_aggregated = 50
#'          )
#'data
#'
#'company_name <- "a"
#'company_name
#'
#'pstr_plot_company(data, company_name)
pstr_plot_company <- function(data, company_name) {
  level_order <- c("low", "medium", "high")

  data |>
    filter(.data$company_name == .env$company_name) |>
    ggplot(aes(x = .data$transition_risk, y = .data$score_aggregated)) +
    scale_x_discrete(limits = level_order) +
    geom_col() +
    facet_grid(.data$company_name ~ .data$scenario + .data$year)
}


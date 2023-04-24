#' Calculate the PCTR indicator
#'
#' ```{r child=extdata_path("child/intro-pctr.Rmd")}
#' ```
#'
#' @inheritParams pctr_score_activities
#' @inheritParams pctr_score_companies
#'
#' @family PCTR functions
#'
#' @return A dataframe with columns `companies_id`, `transition_risk`, and
#'   scores.
#'
#' @export
#'
#' @examples
#' pctr(pctr_companies, pctr_ecoinvent_co2)
pctr <- function(companies, co2, low_threshold = 0.3, high_threshold = 0.7) {
  co2 |>
    pctr_score_activities(
      low_threshold = low_threshold,
      high_threshold = high_threshold
    ) |>
    pctr_score_companies(companies) |>
    xctr_rename()
}

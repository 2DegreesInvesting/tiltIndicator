#' Calculate the PCTR indicator
#'
#' ```{r child=extdata_path("child/intro-pctr.Rmd")}
#' ```
#'
#' @inheritParams pctr_score_activities
#' @inheritParams pctr_at_company_level
#' @param co2 A dataframe with co2 data.
#'
#' @family PCTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' pctr(pctr_companies, pctr_ecoinvent_co2)
pctr <- function(companies, co2, low_threshold = 0.3, high_threshold = 0.7) {
  out <- co2 |>
    pctr_score_activities(
      low_threshold = low_threshold,
      high_threshold = high_threshold
    ) |>
    pctr_at_company_level(companies)

  out |>
    xctr_rename() |>
    relocate_crucial_output_columns()
}

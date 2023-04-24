#' Calculate the ICTR indicator
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' @inheritParams ictr_score_inputs
#' @inheritParams ictr_score_companies
#'
#' @family ICTR functions
#'
#' @return A dataframe with columns `companies_id`, `transition_risk`, and
#'   scores.
#'
#' @export
#'
#' @examples
#' ictr(ictr_companies, ictr_inputs)
ictr <- function(companies, inputs) {
  out <- ictr_score_companies(ictr_score_inputs(inputs), companies)

  out |>
    dplyr::rename(
      companies_id = company_id,
      transition_risk = score
    ) |>
    dplyr::rename_with(~gsub("share_", "score_", .x), dplyr::starts_with("share_"))
}

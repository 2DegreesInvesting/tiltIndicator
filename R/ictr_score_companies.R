#' Aggregate the input products' scores for each company
#'
#' @description
#' Calculates on a company-level the percentage of input products that are in
#' low / medium / high transition risk due to the input products' relative
#' carbon footprint.
#'
#' Activities are mapped with the companies' input products using common columns
#' present in dataframes `ecoinvent_scores` and `companies`.
#'
#' @author Kalash Singhal.
#'
#' @param ecoinvent_scores A [data.frame]. The output of [ictr_score_inputs].
#' @param companies A [data.frame] like [ictr_companies].
#'
#' @family ICTR functions
#'
#' @return A [data.frame] with three rows for each company and these columns:
#'   * `company_id`
#'   * `score`
#'   * `share_all`
#'   * `share_unit`
#'   * `share_sector`
#'   * `share_unit_sec`
#'   where `share_all`, `share_unit`, `share_sector`, and `share_unit_sec` holds
#'   the aggregated scores in percentage.
#'
#' @export
#' @keywords internal
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' one_company <- ictr_companies |> filter(company_id %in% first(company_id))
#' one_company
#'
#' ictr_inputs |>
#'   ictr_score_inputs() |>
#'   ictr_score_companies(one_company)
ictr_score_companies <- function(ecoinvent_scores, companies) {
  stopifnot(hasName(companies, "company_id"))
  stop_if_any_missing_input_co2(ecoinvent_scores)

  companies_scores <- companies |>
    left_join(ecoinvent_scores, by = c("activity_uuid_product_uuid"))

  # For each company show all risk levels even if the share is 0.
  dt_sceleton <- tibble(
    company_id = rep(unique(companies_scores$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(companies_scores$company_id))),
  )

  # Share in comparison to all inputs and those with same unit, sector, ...
  benchmarks <- c("all", "unit", "sector", "unit_sec") |>
    map(~ add_share(companies_scores, .x))

  ictr_output <- append(list(dt_sceleton), benchmarks) |>
    reduce(left_join, by = c("company_id", "score"))

  ictr_output |>
    mutate(
      across(starts_with("share_"), na_to_0_if_not_all_is_na),
      .by = "company_id"
    )
}

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

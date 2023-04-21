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
#' @export
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
  stop_if_any_missing_input_co2(ecoinvent_scores)

  ## join by activity_product_uuid and other joint columns from companies with
  ## ecoinvent_scores
  companies_scores <- companies |>
    left_join(ecoinvent_scores, by = c("activity_product_uuid", "ei_activity", "unit"))

  ## scores in comparison to all input products
  scores_all <- companies_scores |>
    group_by(.data$company_id, .data$score_all) |>
    summarise(n_all = n()) |>
    mutate(share_all = .data$n_all / sum(.data$n_all)) |>
    select(-"n_all") |>
    rename("score" = "score_all")

  ## scores in comparison to input products with same unit
  scores_unit <- companies_scores |>
    group_by(.data$company_id, .data$score_unit) |>
    summarise(n_unit = n()) |>
    mutate(share_unit = .data$n_unit / sum(.data$n_unit)) |>
    select(-"n_unit") |>
    rename("score" = "score_unit")

  ## scores in comparison to input products with same input sector
  scores_sector <- companies_scores |>
    group_by(.data$company_id, .data$score_sector) |>
    summarise(n_sector = n()) |>
    mutate(share_sector = .data$n_sector / sum(.data$n_sector)) |>
    select(-"n_sector") |>
    rename("score" = "score_sector")

  ## scores in comparison to input products with same unit and input sector
  scores_unit_sec <- companies_scores |>
    group_by(.data$company_id, .data$score_unit_sec) |>
    summarise(n_unit_sec = n()) |>
    mutate(share_unit_sec = .data$n_unit_sec / sum(.data$n_unit_sec)) |>
    select(-"n_unit_sec") |>
    rename("score" = "score_unit_sec")

  ## create dataset sceleton
  dt_sceleton <- tibble(
    company_id = rep(unique(companies_scores$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(companies_scores$company_id))),
  )

  ## join scores with dt_sceleton so that each company is shown with 3 rows for
  ## low, medium, and high, even if the share is 0.
  ictr_output <- dt_sceleton |>
    left_join(scores_all, by = c("company_id", "score")) |>
    left_join(scores_unit, by = c("company_id", "score")) |>
    left_join(scores_sector, by = c("company_id", "score")) |>
    left_join(scores_unit_sec, by = c("company_id", "score"))

  ## replace NAs with 0
  ictr_output <- ictr_output |>
    replace(is.na(ictr_output), 0)

  ictr_output
}

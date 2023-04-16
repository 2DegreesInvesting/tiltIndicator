#' Aggregate the products' scores for each company
#'
#' @description
#' Calculates on a company-level the percentage of products that are in low /
#' medium / high transition risk due to the products' relative carbon footprint.
#'
#' Activities are mapped with the companies' products using common columns
#' present in dataframes `scored_activities` and `companies`
#'
#' @author Tilman Trompke.
#'
#' @param scored_activities A [data.frame]. The output of
#'   [pctr_score_activities].
#' @param companies A [data.frame] like [pctr_companies].
#'
#' @family PCTR functions
#'
#' @return A [data.frame] with three rows for each company and these columns:
#'   * `company_id`
#'   * `score`
#'   * `share_all`
#'   * `share_unit`
#'   * `share_unit_sec`
#'   where `share_all`, `share_unit`, and `share_unit_sec` holds the
#'   aggregated scores in percentage.
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' one_company <- pctr_companies |> filter(company_id %in% first(company_id))
#' one_company
#'
#' pctr_ecoinvent_co2 |>
#'   pctr_score_activities(low_threshold = 0.3, high_threshold = 0.7) |>
#'   pctr_score_companies(one_company)
pctr_score_companies <- function(scored_activities, companies) {
  # Intermediate steps:
  # * Combine company-level information with LCA info from ecoinvent.
  # * Calculate the share of products with each score.

  # join by activity_product_uuid and other joint columns from companies with scored_activities
  companies_scores <- companies |>
    left_join(scored_activities, by = c("activity_product_uuid", "ei_activity", "unit"))

  # scores in comparison to all products
  scores_all <- companies_scores |>
    group_by(.data$company_id, .data$score_all) |>
    summarise(n_all = n()) |>
    mutate(share_all = .data$n_all / sum(.data$n_all)) |>
    select(-"n_all") |>
    rename("score" = "score_all")

  # scores in comparison to products with same unit
  scores_unit <- companies_scores |>
    group_by(.data$company_id, .data$score_unit) |>
    summarise(n_unit = n()) |>
    mutate(share_unit = .data$n_unit / sum(.data$n_unit)) |>
    select(-"n_unit") |>
    rename("score" = "score_unit")

  # scores in comparison to products with same unit and sector
  scores_unit_sec <- companies_scores |>
    group_by(.data$company_id, .data$score_unit_sec) |>
    summarise(n_unit_sec = n()) |>
    mutate(share_unit_sec = .data$n_unit_sec / sum(.data$n_unit_sec)) |>
    select(-"n_unit_sec") |>
    rename("score" = "score_unit_sec")

  # create dataset sceleton
  dt_sceleton <- tibble(
    company_id = rep(unique(companies_scores$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(companies_scores$company_id))),
  )

  # join scores with dt_sceleton so that each company is shown with 3 rows for low, medium, and high, even if the share is 0.
  scored_companies <- dt_sceleton |>
    left_join(scores_all, by = c("company_id", "score")) |>
    left_join(scores_unit, by = c("company_id", "score")) |>
    left_join(scores_unit_sec, by = c("company_id", "score"))

  # replace NAs with 0
  scored_companies <- scored_companies |>
    replace(is.na(scored_companies), 0)

  scored_companies
}

xctr_polish_output_at_company_level <- function(data) {
  data |>
    xctr_rename_at_company_level() |>
    xctr_pivot_score() |>
    relocate(all_of(cols_at_company_level())) |>
    arrange(.data$companies_id, .data$grouped_by)
}

xctr_pivot_score <- function(data) {
  data |>
    pivot_longer(
      starts_with("score_"),
      names_prefix = "score_",
      names_to = "grouped_by"
    )
}

xctr_rename_at_company_level <- function(data) {
  data |>
    rename(
      companies_id = "company_id",
      risk_category = "score"
    ) |>
    rename_with(~ gsub("share_", "score_", .x), starts_with("share_"))
}

add_share <- function(data, suffix) {
  score_col <- paste0("score_", suffix)
  share_col <- paste0("share_", suffix)

  data |>
    group_by(.data$company_id, .data[[score_col]]) |>
    filter(!is.na(.data[[score_col]])) |>
    summarise(.n = n()) |>
    mutate({{ share_col }} := .data$.n / sum(.data$.n)) |>
    rename("score" = all_of(score_col)) |>
    select(-all_of(".n"))
}

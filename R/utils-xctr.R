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

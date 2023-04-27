xctr_rename <- function(data) {
  data |>
    rename(id = "company_id", transition_risk = "score") |>
    rename_with(~ gsub("share_", "score_", .x), starts_with("share_"))
}

#' Count `score_{suffix}` into `share_{suffix}`
count_share <- function(data, suffix) {
  score_col <- paste0("score_", suffix)
  stopifnot(hasName(data, score_col))
  share_col <- paste0("share_", suffix)

  data |>
    group_by(.data$company_id, .data[[score_col]]) |>
    filter(!is.na(.data[[score_col]])) |>
    summarise(.n = n()) |>
    mutate({{share_col}} := .data$.n / sum(.data$.n)) |>
    rename("score" = all_of(score_col)) |>
    select(-all_of(".n"))
}

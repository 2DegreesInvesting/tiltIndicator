xctr_rename <- function(data) {
  data |>
    rename(
      id = company_id,
      transition_risk = score
    ) |>
    rename_with(~ gsub("share_", "score_", .x), starts_with("share_"))
}

rename_xctr <- function(data) {
  data |>
    dplyr::rename(
      companies_id = company_id,
      transition_risk = score
    ) |>
    dplyr::rename_with(~gsub("share_", "score_", .x), dplyr::starts_with("share_"))
}

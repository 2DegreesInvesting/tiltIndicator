xctr_at_company_level <- function(data,
                                  benchmarks = c("all", "unit", "sector", "unit_sec")) {
  # For each company show all risk levels even if the share is 0.
  dt_sceleton <- tibble(
    company_id = rep(unique(data$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(data$company_id))),
  )

  .benchmarks <- map(benchmarks, ~ add_share(data, .x))

  ictr_output <- append(list(dt_sceleton), .benchmarks) |>
    reduce(left_join, by = c("company_id", "score"))

  ictr_output |>
    mutate(
      across(starts_with("share_"), na_to_0_if_not_all_is_na),
      .by = "company_id"
    )
}

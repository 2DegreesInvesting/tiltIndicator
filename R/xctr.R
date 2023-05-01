xctr_score_companies <- function(co2,
                                 companies,
                                 uuid = "activity_uuid_product_uuid",
                                 benchmarks = c("all", "unit", "sector", "unit_sec")) {
  stopifnot(hasName(companies, "company_id"))

  companies_scores <- left_join(companies, co2, by = c(uuid))

  # For each company show all risk levels even if the share is 0.
  dt_sceleton <- tibble(
    company_id = rep(unique(companies_scores$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(companies_scores$company_id))),
  )

  # Share in comparison to all inputs and those with same unit, sector, ...
  benchmarks_list <- map(benchmarks, ~ add_share(companies_scores, .x))

  ictr_output <- append(list(dt_sceleton), benchmarks_list) |>
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

xctr_score_companies <- function(companies,
                                 co2,
                                 uuid = "activity_uuid_product_uuid",
                                 .by = c("all", "unit", "sector", "unit_sec")) {
  stopifnot(hasName(companies, "company_id"))

  companies_scores <- left_join(companies, co2, by = c(uuid))

  # For each company show all risk levels even if the share is 0.
  dt_sceleton <- tibble(
    company_id = rep(unique(companies_scores$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(companies_scores$company_id))),
  )

  # Share in comparison to all inputs and those with same unit, sector, ...
  benchmarks_list <- map(.by, ~ add_share(companies_scores, .x))

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

xctr_add_ranks <- function(data, x, .by) {
  out <- data
  for (i in seq_along(.by)) {
    out <- add_rank(out, x, .by = .by[[i]])
  }
  out
}

add_rank <- function(data, x, .by) {
  if (identical(.by, "all")) {
    suffix <- "all"
    ..by <- NULL
  } else {
    suffix <- paste(.by, collapse = "_")
    ..by <- .by
  }

  nm <- as.symbol(paste0("perc_", suffix))
  mutate(data, "{{ nm }}" := rank_proportion(.data[[x]]), .by = all_of(..by))
}

rank_proportion <- function(x) {
  rank(x) / length(x)
}

xctr_add_scores <- function(data, low_threshold = 0.3, high_threshold = 0.7){
  for (col in colnames(select(data, starts_with("perc_")))) {
    suffix <- substring(col, 6)
    score_col <- paste0("score_", suffix)
    # assign scores to each "perc_" column
    data <- data |> mutate({{ score_col }} := case_when(
      .data[[col]] < low_threshold ~ "low",
      .data[[col]] >= low_threshold & .data[[col]] < high_threshold ~ "medium",
      .data[[col]] >= high_threshold ~ "high"
    ))
  }
  data
}

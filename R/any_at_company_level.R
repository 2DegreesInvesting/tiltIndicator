any_at_company_level <- function(data) {
  with_value <- data |>
    select(all_of(cols_at_all_levels())) |>
    filter(!is.na(.data$risk_category)) |>
    add_count(.data$companies_id, .data$grouped_by) |>
    mutate(value = .data$n / sum(.data$n), .by = cols_by()) |>
    select(-"n")

  all_unmatched <- identical(nrow(with_value), 0L)
  if (all_unmatched) {
    return(empty_company_output_from(data$companies_id))
  }

  unmatched <- setdiff(unique(data$companies_id), unique(with_value$companies_id))
  some_unmatched <- length(unmatched) > 0L
  if (some_unmatched) {
    with_value <- bind_rows(with_value, empty_company_output_from(unmatched))
  }

  levels <- risk_category_levels()
  with_value |>
    group_by(.data$companies_id, .data$grouped_by) |>
    mutate(risk_category = factor(.data$risk_category, levels = levels)) |>
    expand(.data$risk_category) |>
    filter(!is.na(.data$risk_category)) |>
    left_join(with_value, by = cols_at_all_levels()) |>
    ungroup() |>
    mutate(
      value = na_to_0_if_not_all_is_na(.data$value),
      .by = cols_by()
    ) |>
    # Hack #285. FIXME: Explore why this happens
    summarize(
      value = sum(.data$value),
      .by = cols_at_all_levels()
    ) |>
    polish_output(level_cols = cols_at_company_level())
}

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

empty_company_output_from <- function(companies_id) {
  tibble(
    companies_id = unique(companies_id),
    grouped_by = NA_character_,
    risk_category = NA_character_,
    value = NA_real_
  )
}

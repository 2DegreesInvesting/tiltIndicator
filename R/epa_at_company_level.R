epa_at_company_level <- function(data) {
  with_value <- data |>
    select(all_of(cols_at_all_levels())) |>
    add_count(.data$companies_id, .data$grouped_by) |>
    mutate(value = .data$n / sum(.data$n), .by = cols_by()) |>
    select(-"n")

  if (all_na(with_value, "grouped_by", "risk_category")) {
    return(empty_company_output_from(data$companies_id))
  }

  with_value <- bind_rows(
    pick_companies_with_no_match(with_value),
    pick_companies_with_some_match(with_value)
  )

  levels <- c(risk_category_levels(), NA)
  with_value |>
    group_by(.data$companies_id, .data$grouped_by) |>
    mutate(risk_category = factor(.data$risk_category, levels = levels)) |>
    expand(.data$risk_category) |>
    left_join(with_value, by = cols_at_all_levels()) |>
    ungroup() |>
    mutate(
      value = replace_na(.data$value, 0),
      .by = cols_by()
    ) |>
    # Hack #285. FIXME: Explore why this happens
    summarize(
      value = sum(.data$value),
      .by = cols_at_all_levels()
    )
}

all_na <- function(data, ...) {
  data |>
    select(...) |>
    lapply(is.na) |>
    unlist() |>
    all()
}

pick_companies_with_no_match <- function(data) {
  data |>
    mutate(all_na_grouped_by = all(is.na(.data$grouped_by)), .by = "companies_id") |>
    filter(.data$all_na_grouped_by) |>
    select(-"all_na_grouped_by") |>
    pull(.data$companies_id) |>
    empty_company_output_from()
}

pick_companies_with_some_match <- function(data) {
  data |>
    mutate(all_na_grouped_by = all(is.na(.data$grouped_by)), .by = "companies_id") |>
    filter(!.data$all_na_grouped_by, !is.na(.data$grouped_by)) |>
    select(-"all_na_grouped_by")
}

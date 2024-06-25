sector_profile_at_product_level <- function(companies,
                                            scenarios,
                                            low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                                            high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  x <- list(companies = companies, scenarios = scenarios)
  spa_check(x)

  .companies <- prepare_companies(companies)
  .scenarios <- prepare_scenarios(scenarios, low_threshold, high_threshold)

  .companies |>
    spa_compute_profile_ranking(.scenarios) |>
    add_risk_category(low_threshold, high_threshold, .default = NA) |>
    spa_polish_output_at_product_level() |>
    sp_select_cols_at_product_level() |>
    mutate(grouped_by = ifelse(
      grepl("NA", .data$grouped_by), NA_character_, .data$grouped_by
    )) |>
    if_necessary_fill_grouped_by_with(scenarios) |>
    arrange_id_using(.companies)
}

sp_select_cols_at_product_level <- function(data) {
  data |>
    select(
      ends_with(rowid()),
      all_of(sp_cols_at_product_level())
    )
}

sp_cols_at_product_level <- function() {
  c(
    spa_cols_at_product_level(),
    aka("tsector_old")
  )
}

if_necessary_fill_grouped_by_with <- function(data, scenarios) {
  .out <- data |>
    mutate(
      all_na = all(is.na(.data$grouped_by)),
      .by = c(aka("id"), aka("cluster"))
    )

  no_fill <- filter(.out, all_na)
  to_fill <- filter(.out, !all_na)

  nothing_to_fill <- identical(nrow(to_fill), 0L)
  if (nothing_to_fill) {
    filled <- to_fill
  } else {
    filled <- to_fill |> fill_grouped_by_with(scenarios)
  }

  bind_rows(filled, no_fill) |> select(-all_na)
}

fill_grouped_by_with <- function(data, scenarios) {
  levels <- pull(distinct_grouped_by(scenarios))
  data |>
    filter(!is.na(.data$grouped_by)) |>
    group_by(.data[[aka("id")]], .data[[aka("cluster")]]) |>
    mutate(grouped_by = factor(.data$grouped_by, levels = levels)) |>
    expand(.data$grouped_by) |>
    left_join(data, by = c(aka("id"), aka("cluster"), "grouped_by")) |>
    ungroup() |>
    relocate(names(data))
}

distinct_grouped_by <- function(data) {
  data |>
    distinct(
      .data[[aka("scenario_type")]],
      .data[[aka("scenario_name")]],
      .data[[aka("xyear")]]
    ) |>
    unite(
      "grouped_by",
      aka("scenario_type"),
      aka("scenario_name"),
      aka("xyear")
    )
}

arrange_id_using <- function(x, y) {
  x |> arrange(match(.data[[aka("id")]], y[[aka("id")]]))
}

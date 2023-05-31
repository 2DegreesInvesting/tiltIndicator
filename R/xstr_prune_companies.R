#' Drop rows where the product info is `NA` & sector info is duplicated
#'
#' For each company, this function drops rows where the product information is
#' missing and the sector information is duplicated.
#'
#' @param data Typically an XSTR `*companies` dataframe.
#'
#' @family helpers
#'
#' @return A dataframe with maybe fewer rows than the input `data`.
#' @export
#'
#' @examples
#' # styler: off
#' companies <- tibble::tribble(
#'   ~row_id, ~companies_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector,
#'   # Keep: Has product info
#'         1,           "a",       "b1",                        "c1",          "x",
#'   # Drop: Lacks product info and sector info is duplicated
#'         2,           "a",         NA,                          NA,          "x",
#'   # Drop: Lacks product info and sector info is duplicated
#'         3,           "a",         NA,                          NA,          "x",
#'   # Keep: Lacks product info but sector info is unique
#'         4,           "a",         NA,                          NA,          "y",
#'   # Drop: Lacks product info and sector info is duplicated
#'         5,           "a",         NA,                          NA,          "y",
#'   # Keep: Has product info
#'         6,           "a",       "b6",                        "c6",          "z",
#'   # Keep: Has product info
#'         7,           "a",       "b7",                          NA,          "z",
#' )
#' # styler: on
#'
#' xstr_prune_companies(companies)
xstr_prune_companies <- function(data) {
  data |>
    flag_companies() |>
    pick_companies()
}

flag_companies <- function(data) {
  data |>
    group_by(.data$companies_id, .data$tilt_sector) |>
    mutate(odd = ifelse(
      is.na(.data$clustered) & is.na(.data$activity_uuid_product_uuid),
      TRUE,
      FALSE
    )) |>
    rowid_to_column() |>
    arrange(.data$odd, .by_group = TRUE) |>
    mutate(odd_and_first = .data$odd & row_number() == 1L) |>
    arrange(.data$rowid) |>
    select(-"rowid") |>
    mutate(keep = case_when(
      !.data$odd ~ TRUE,
      .data$odd & .data$odd_and_first ~ TRUE,
      .default = FALSE
    )) |>
    ungroup()
}

pick_companies <- function(data) {
  data |>
    filter(.data$keep) |>
    select(-"odd", -"odd_and_first", -"keep")
}

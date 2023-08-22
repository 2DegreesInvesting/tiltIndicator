#' Drop rows where the product info is `NA` & sector info is duplicated
#'
#' For each company, this function drops rows where the product information is
#' missing and the sector information is duplicated.
#'
#' @param data Typically an XSTR `*companies` dataframe.
#'
#' @family pre-processing helpers
#'
#' @return A dataframe with maybe fewer rows than the input `data`.
#' @export
#'
#' @examples
#' # styler: off
#' companies <- tibble::tribble(
#'   ~row, ~company_id, ~clustered, ~activity_uuid_product_uuid, ~tilt_sector,
#'   # Keep: Has product info
#'      1,         "a",       "b1",                        "c1",          "x",
#'   # Drop: Lacks product info and sector info is duplicated
#'      2,         "a",         NA,                          NA,          "x",
#'   # Keep: Lacks product info but sector info is unique
#'      3,         "a",         NA,                          NA,          "y",
#'   # Drop: Lacks product info and sector info is duplicated
#'      4,         "a",         NA,                          NA,          "y",
#' )
#' # styler: on
#'
#' sector_profile_any_prune_companies(companies)
sector_profile_any_prune_companies <- function(data) {
  check_prune_companies(data)

  data |>
    flag_companies() |>
    pick_companies()
}

check_prune_companies <- function(data) {
  check_crucial_names(data, c(
    "company_id", "clustered", "activity_uuid_product_uuid", "tilt_sector"
  ))
}

flag_companies <- function(data) {
  data |>
    group_by(.data$company_id, .data$tilt_sector) |>
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

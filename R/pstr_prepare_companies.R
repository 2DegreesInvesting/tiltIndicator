#' Given a messy PSTR `companies` dataframe returns a cleaner one
#'
#' @param data A dataframe with these columns:
#' * ipr_sector.x
#' * ipr_sector.y
#' * ipr_subsector.x
#' * ipr_subsector.y
#' * weo_product.x
#' * weo_product.y
#' * weo_flow.x
#' * weo_flow.y
#'
#' @family pre-processing helpers
#'
#' @return A `copmanies` dataset as required by PSTR functions.
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' library(readr, warn.conflicts = FALSE)
#'
#' raw_companies <- read_csv(extdata_path("pstr_raw_companies.csv"))
#' glimpse(raw_companies)
#'
#' companies <- pstr_prepare_companies(raw_companies)
#' companies
pstr_prepare_companies <- function(data) {
  data |>
    merge_scenario_columns() |>
    lowercase_characters() |>
    pivot_type_sector_subsector()
}

merge_scenario_columns <- function(data) {
  data |>
    mutate(ipr_sector = if_else(is.na(.data$ipr_sector.y), .data$ipr_sector.x, .data$ipr_sector.y)) |>
    mutate(ipr_subsector = if_else(is.na(.data$ipr_subsector.y), .data$ipr_subsector.x, .data$ipr_subsector.y)) |>
    mutate(weo_product = if_else(is.na(.data$weo_product.y), .data$weo_product.x, .data$weo_product.y)) |>
    mutate(weo_flow = if_else(is.na(.data$weo_flow.y), .data$weo_flow.x, .data$weo_flow.y)) |>
    select(-ends_with(".x")) |>
    select(-ends_with(".y")) |>
    distinct()
}

pivot_type_sector_subsector <- function(companies) {
  companies |>
    rename(weo_sector = weo_product, weo_subsector = weo_flow) |>
    pivot_longer(c("ipr_sector", "ipr_subsector", "weo_sector", "weo_subsector")) |>
    # FIXME: ?separate() has been superseded in favour of
    # separate_wider_position() and separate_wider_delim()
    separate(.data$name, c("type", "tmp")) |>
    pivot_wider(names_from = "tmp")
}

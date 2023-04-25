#' Title
#' TODO
#' @param data
#'
#' @return
#' @export
#'
#' @examples
pstr_prepare_companies <- function(data) {
  data |>
    merge_scenario_columns() |>
    lowercase_characters() |>
    pivot_type_sector_subsector()
}

#' Title
#' TODO
#' @param data
#'
#' @return
#' @noRd
#'
#' @examples
merge_scenario_columns <- function(data) {
  data |>
    mutate(ipr_sector = if_else(is.na(ipr_sector.y), ipr_sector.x, ipr_sector.y)) |>
    mutate(ipr_subsector = if_else(is.na(ipr_subsector.y), ipr_subsector.x, ipr_subsector.y)) |>
    mutate(weo_product = if_else(is.na(weo_product.y), weo_product.x, weo_product.y)) |>
    mutate(weo_flow = if_else(is.na(weo_flow.y), weo_flow.x, weo_flow.y)) |>
    select(-ends_with(".x")) |>
    select(-ends_with(".y")) |>
    distinct()
}

#' Title
#' TODO
#' @param companies
#'
#' @return
#' @noRd
#'
#' @examples
pivot_type_sector_subsector <- function(companies) {
  companies |>
    rename(weo_sector = weo_product, weo_subsector = weo_flow) |>
    pivot_longer(c(ipr_sector, ipr_subsector, weo_sector, weo_subsector)) |>
    separate(name, c("type", "tmp")) |>
    pivot_wider(names_from = "tmp")
}

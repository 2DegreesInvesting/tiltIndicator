#' Restructure XSTR `companies`
#'
#' @param data A dataframe with these columns:
#' * ipr_sector
#' * ipr_subsector
#' * weo_product
#' * weo_flow
#'
#' @family pre-processing helpers
#'
#' @return A `companies` dataset as required by PSTR functions.
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' library(readr, warn.conflicts = FALSE)
#'
#' raw_companies <- read_csv(extdata_path("pstr_companies.csv"))
#' glimpse(raw_companies)
#'
#' companies <- xstr_pivot_type_sector_subsector(raw_companies)
#' companies
xstr_pivot_type_sector_subsector <- function(data) {
  data |>
    lowercase_characters() |>
    rename(weo_sector = "weo_product", weo_subsector = "weo_flow") |>
    pivot_longer(c("ipr_sector", "ipr_subsector", "weo_sector", "weo_subsector")) |>
    separate_wider_delim("name", delim = "_", names = c("type", "tmp")) |>
    pivot_wider(names_from = "tmp")
}

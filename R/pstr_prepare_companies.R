#' Given a messy PSTR `companies` dataframe returns a cleaner one
#'
#' @param data A dataframe with these columns:
#' * ipr_sector
#' * ipr_subsector
#' * weo_product
#' * weo_flow
#'
#' @family helpers
#'
#' @return A `copmanies` dataset as required by PSTR functions.
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' library(readr, warn.conflicts = FALSE)
#'
#' raw_companies <- read_csv(extdata_path("pstr_companies.csv"))
#' glimpse(raw_companies)
#'
#' companies <- pstr_prepare_companies(raw_companies)
#' companies
pstr_prepare_companies <- function(data) {
  data |>
    lowercase_characters() |>
    pivot_type_sector_subsector()
}

pivot_type_sector_subsector <- function(companies) {
  companies |>
    rename(weo_sector = "weo_product", weo_subsector = "weo_flow") |>
    pivot_longer(c("ipr_sector", "ipr_subsector", "weo_sector", "weo_subsector")) |>
    # FIXME: ?separate() has been superseded in favour of
    # separate_wider_position() and separate_wider_delim()
    separate_wider_delim("name", delim = "_", names = c("type", "tmp")) |>
    pivot_wider(names_from = "tmp")
}

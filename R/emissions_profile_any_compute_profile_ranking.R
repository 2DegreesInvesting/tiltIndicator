#' Add values to categorize
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function was deprecated because it's internal. Users don't need to
#' interact with the function itself.
#'
#' @param data A "co2-like" data frame -- i.e. containing products or
#'   upstream-products (a.k.a. inputs).
#'
#' @keywords internal
#'
#' @return The input data frame with the additional columns `grouped_by` and
#'   `profile_ranking` and one row per benchmark per company.
#'
#' @export
#'
#' @examples
#' library(tiltToyData)
#' library(readr, warn.conflicts = FALSE)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_emissions_profile_any_companies())
#'
#' products <- read_csv(toy_emissions_profile_products_ecoinvent())
#' products |> emissions_profile_any_compute_profile_ranking()
#'
#' inputs <- read_csv(toy_emissions_profile_upstream_products_ecoinvent())
#' inputs |> emissions_profile_any_compute_profile_ranking()
emissions_profile_any_compute_profile_ranking <- function(data) {
  lifecycle::deprecate_warn(
    "0.0.0.9109",
    "emissions_profile_any_compute_profile_ranking()",
    details = "This function is now internal."
  )
  epa_compute_profile_ranking(data)
}

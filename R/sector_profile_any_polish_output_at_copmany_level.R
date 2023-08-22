#' Polish output at company level
#'
#' @param data The output of `sector_profile*()` functions.
#'
#' @family post-processing helpers
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' library(tiltToyData)
#' library(readr)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_sector_profile_companies())
#' scenarios <- read_csv(toy_sector_profile_any_scenarios())
#'
#' sector_profile(companies, scenarios) |>
#'   unnest_company() |>
#'   sector_profile_any_polish_output_at_company_level()
#'
#' companies_upstream <- read_csv(toy_sector_profile_upstream_companies())
#' products_upstream <- read_csv(toy_sector_profile_upstream_products())
#'
#' sector_profile_upstream(companies_upstream, scenarios, products_upstream) |>
#'   unnest_company() |>
#'   sector_profile_any_polish_output_at_company_level()
sector_profile_any_polish_output_at_company_level <- function(data) {
  separate_wider_delim(
    data,
    cols = "grouped_by",
    delim = "_",
    names = c("type", "scenario", "year")
  )
}

#' Polish output at company level
#'
#' @param data The output of `xstr*()` functions.
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
#' toy_files()
#'
#' companies <- read_csv(toy_path("sector_profile_companies.csv.gz"))
#' scenarios <- read_csv(toy_path("sector_profile_any_scenarios.csv.gz"))
#' sector_profile(companies, scenarios) |>
#'   unnest_company() |>
#'   xstr_polish_output_at_company_level()
#'
#' companies_up <- read_csv(toy_path("sector_profile_upstream_companies.csv.gz"))
#' products_up <- read_csv(toy_path("sector_profile_upstream_products.csv.gz"))
#'
#' sector_profile_upstream(companies_up, scenarios, products_up) |>
#'   unnest_company() |>
#'   xstr_polish_output_at_company_level()
xstr_polish_output_at_company_level <- function(data) {
  separate_wider_delim(
    data,
    cols = "grouped_by",
    delim = "_",
    names = c("type", "scenario", "year")
  )
}

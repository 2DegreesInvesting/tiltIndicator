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
#' companies <- toy_path("sector_profile_companies.csv.gz") |>
#'   read_csv()
#' scenarios <- toy_path("sector_profile_any_scenarios.csv.gz") |>
#'   read_csv()
#' sector_profile(companies, scenarios) |>
#'   unnest_company() |>
#'   xstr_polish_output_at_company_level()
#'
#' companies <- toy_path("sector_profile_upstream_companies.csv.gz") |>
#'   read_csv()
#' upstream_products <- toy_path("sector_profile_upstream_products.csv.gz") |>
#'   read_csv(col_types = cols(input_isic_4digit = col_character()))
#' sector_profile_upstream(companies, scenarios, upstream_products) |>
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

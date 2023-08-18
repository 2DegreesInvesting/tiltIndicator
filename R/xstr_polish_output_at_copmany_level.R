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
#' sector_profile(companies, xstr_scenarios) |>
#'   unnest_company() |>
#'   xstr_polish_output_at_company_level()
#'
#' sector_profile_upstream(istr_companies, xstr_scenarios, istr_inputs) |>
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

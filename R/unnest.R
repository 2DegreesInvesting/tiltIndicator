#' Unnest product- and company-level results
#'
#' @param data A nested data frame, e.g. the output of [sector_profile()].
#'
#' @family helpers
#'
#' @return A data frame.
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
#'
#' both <- sector_profile(companies, scenarios)
#' both
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()
unnest_product <- function(data) {
  nested <- select(data, -"company")
  unnest(nested, "product")
}

#' @export
#' @rdname unnest_product
unnest_company <- function(data) {
  nested <- select(data, -"product")
  unnest(nested, "company")
}

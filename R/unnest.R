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
#' companies <- read_csv(toy_sector_profile_companies())
#' scenarios <- read_csv(toy_sector_profile_any_scenarios())
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

#' @examples
#' library(tiltIndicator)
#' library(tiltToyData)
#' library(readr)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_emissions_profile_any_companies())
#' products <- read_csv(toy_emissions_profile_products())
#'
#' both <- emissions_profile(companies, products)
#' both
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()

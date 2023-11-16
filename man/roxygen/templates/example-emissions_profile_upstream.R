#' @examples
#' library(tiltToyData)
#' library(readr)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_emissions_profile_any_companies())
#' inputs <- read_csv(toy_emissions_profile_upstream_products())
#'
#' both <- emissions_profile_upstream(companies, inputs)
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()

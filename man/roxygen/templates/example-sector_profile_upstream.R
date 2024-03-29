#' @examples
#' library(tiltIndicator)
#' library(tiltToyData)
#' library(readr)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_sector_profile_upstream_companies())
#' scenarios <- read_csv(toy_sector_profile_any_scenarios())
#' inputs <- read_csv(toy_sector_profile_upstream_products())
#'
#' both <- sector_profile_upstream(companies, scenarios, inputs)
#' both
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()

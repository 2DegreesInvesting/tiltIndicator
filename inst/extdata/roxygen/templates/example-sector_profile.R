#' @examples
#' library(tiltIndicator)
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


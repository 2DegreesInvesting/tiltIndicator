#' Calculate the indicator "emissions profile upstream"
#'
#' ```{r child=extdata_path("child/intro-emissions-profile-upstream.Rmd")}
#' ```
#'
#' @name emissions_profile_upstream
#' @inherit emissions_profile
#' @family main functions
#'
#' @examples
#' library(tiltToyData)
#' library(readr)
#' options(readr.show_col_types = FALSE)
#'
#' companies <- read_csv(toy_emissions_profile_any_companies())
#' upstream_products <- read_csv(toy_path("emissions_profile_upstream_products.csv.gz"))
#'
#' both <- emissions_profile_upstream(companies, upstream_products)
#'
#' both |> unnest_product()
#'
#' both |> unnest_company()
NULL

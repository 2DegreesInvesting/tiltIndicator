#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [istr_companies].
#' @param scenarios A dataframe like [istr_weo_2022].
#' @param mapper A dataframe like [istr_ep_weo].
#' @inheritParams xctr
#' @inheritParams pstr
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- istr_companies
#' scenarios <- istr_weo_2022
#' mapper <- istr_ep_weo
#'
#' # Product level
#' companies |>
#'   istr_at_product_level(scenarios, mapper)
#'
#' # Company level
#' companies |>
#'   istr_at_product_level(scenarios, mapper) |>
#'   istr_at_company_level()
#'
#' # Same
#' istr(companies, scenarios, mapper)
istr <- function(companies, scenarios, mapper) {
  companies |>
    istr_at_product_level(scenarios, mapper) |>
    xctr_at_company_level()
}

#' @rdname istr
#' @export
istr_at_product_level <- function(companies,
                                  scenarios,
                                  mapper,
                                  low_threshold = 30,
                                  high_threshold = 70) {
  check_has_no_na(scenarios, "reductions")

  companies |>
    istr_mapping(mapper) |>
    istr_add_reductions(scenarios) |>
    pstr_categorize_risk(low_threshold, high_threshold) |>
    xstr_polish_output_at_product_level()
}

istr_mapping <- function(companies, ep_weo) {
  companies |>
    left_join(ep_weo, by = c("eco_sectors" = "ECO_sector"))
}

istr_add_reductions <- function(companies, weo_2022) {
  companies |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

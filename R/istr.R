#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [istr_companies].
#' @param scenario A dataframe like [istr_weo_2022].
#' @param mapper A dataframe like [istr_ep_weo].
#' @param data A dataframe. The output at product level.
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- istr_companies
#' scenario <- istr_weo_2022
#' mapper <- istr_ep_weo
#'
#' # Product level
#' companies |>
#'   istr_at_product_level(scenario, mapper)
#'
#' # Company level
#' companies |>
#'   istr_at_product_level(scenario, mapper) |>
#'   xctr_at_company_level()
#'
#' # Same
#' istr(companies, scenario, mapper)
istr <- function(companies, scenario, mapper) {
  companies |>
    istr_at_product_level(scenario, mapper) |>
    xctr_at_company_level()
}

#' @rdname istr
#' @export
istr_at_product_level <- function(companies, scenario, mapper) {
  companies |>
    istr_mapping(mapper) |>
    istr_add_reductions(scenario) |>
    istr_add_transition_risk() |>
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

istr_add_transition_risk <- function(with_reductions) {
  with_reductions |>
    mutate(
      transition_risk = case_when(
        reductions <= 30 ~ "low",
        reductions > 30 & reductions <= 70 ~ "medium",
        reductions >= 70 ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

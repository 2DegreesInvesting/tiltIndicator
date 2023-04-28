#' Create a toy data set for the pstr_old_companies data set.
#'
#' @param company_id An integer.
#' @param company_name A string.
#' @param products A string.
#' @param sector A string.
#' @param subsector A string.
#'
#' @return A toy data set that have the same columns as
#' `pstr_old_companies`.
#' @noRd
pstr_toy_companies <- function(company_id = 1, company_name = "a",
                               products = "b", sector = "c",
                               subsector = "d", ...) {
  tibble(
    company_id = company_id,
    company_name = company_name,
    products = products,
    sector = sector,
    subsector = subsector,
    ...
  )
}

#' Create a toy data set for the pstr_ep_weo data set.
#'
#' @param EP_categories_id A numeric.
#' @param EP_group A string.
#' @param EP_sector A string.
#' @param EP_subsector A string.
#' @param weo_product_mapper A string.
#' @param weo_flow_mapper A string.
#'
#' @return A toy data set that has the same columns as `pstr_ep_weo`.
#' @noRd
pstr_toy_ep_weo <- function(EP_categories_id = 1, EP_group = "a",
                            EP_sector = "c", EP_subsector = "d",
                            weo_product_mapper = "e", weo_flow_mapper = "f", ...) {
  tibble(
    EP_categories_id = EP_categories_id,
    EP_group = EP_group,
    EP_sector = EP_sector,
    EP_subsector = EP_subsector,
    weo_product_mapper = weo_product_mapper,
    weo_flow_mapper = weo_flow_mapper,
    ...
  )
}

#' Create a toy data set for the pstr_weo_2022 data set
#'
#' @param publication A string.
#' @param scenario A string.
#' @param region A string.
#' @param category A string.
#' @param product A string.
#' @param flow A string.
#' @param unit A string.
#' @param year A numeric.
#' @param value A numeric.
#' @param reductions A numeric.
#'
#' @return A toy data set that has the same columns as `pstr_weo_2022`.
#' @noRd
pstr_toy_weo_2022 <- function(publication = "A", scenario = "B", region = "C",
                              category = "D", product = "e",
                              flow = "f", unit = "F", year = 1,
                              value = 2, reductions = 3, ...) {
  tibble(
    publication = publication,
    scenario = scenario,
    region = region,
    category = category,
    product = product,
    flow = flow,
    unit = unit,
    year = year,
    value = value,
    reductions = reductions,
    ...
  )
}

#' Lowercase characters in data
#'
#' @param data A data frame.
#'
#' @return A [data.frame] with the values of its character content lower cased.
#'
#' @examples # TODO
#' @noRd
lowercase_characters <- function(data) {
  mutate(data, across(where(is.character), tolower))
}

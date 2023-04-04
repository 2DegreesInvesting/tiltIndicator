#' Create a toy data set for the pstr_companies data set.
#'
#' @param company_id An integer.
#' @param company_name A string.
#' @param products A string.
#' @param sector A string.
#' @param subsector A string.
#'
#' @return A toy data set that have the same columns as
#' `pstr_companies`.
#' @noRd
pstr_toy_companies <- function(company_id = 1, company_name = "a",
                                 products = "b", sector = "c",
                                 subsector = "d") {
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
#' @param EP_categories_id
#' @param EP_group
#' @param EP_sector
#' @param EP_subsector
#' @param weo_product_mapper
#' @param weo_flow_mapper
#'
#' @return A toy data set that has the same columns as `pstr_ep_weo`.
#' @noRd
pstr_toy_ep_weo <- function(EP_categories_id = 1, EP_group = "a",
                              EP_sector = "c", EP_subsector = "d",
                              weo_product_mapper = "e", weo_flow_mapper = "f") {
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
#' @param publication
#' @param scenario
#' @param region
#' @param category
#' @param product
#' @param flow
#' @param unit
#' @param year
#' @param value
#' @param reductions
#'
#' @return A toy data set that has the same columns as `pstr_weo_2022`.
#' @noRd
pstr_toy_weo_2022 <- function(publication = "A", scenario = "B", region = "C",
                                category = "D", product = "b",
                                flow = "E", unit = "F", year = 1,
                                value = 2, reductions = 3) {
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



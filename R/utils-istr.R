istr_toy_companies <- function() {
  tibble(
    company_name = "abc",
    eco_sectors = "steel_metal_transformation"
  )
}

istr_toy_ep_weo <- function() {
  tibble(
    ECO_sector = "steel_metal_transformation",
    weo_product_mapper = "Total",
    weo_flow_mapper = "Iron and steel"
  )
}

istr_toy_weo <- function() {
  tibble(
    scenario = "Stated Policies Scenario",
    product = "Total",
    flow = "Road passenger light duty vehicle",
    year = 2020,
    reductions = 0
  )
}

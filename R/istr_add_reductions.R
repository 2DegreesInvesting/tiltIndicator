istr_add_reductions <- function(companies, weo_2022) {
  companies |>
    # left_join(ep_weo, by = c("eco_sectors" = "ECO_sector")) |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

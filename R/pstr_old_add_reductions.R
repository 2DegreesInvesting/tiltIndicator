pstr_old_add_reductions <- function(companies, ep_weo, weo_2022) {
  companies |>
    left_join(ep_weo, by = c("sector" = "EP_sector", "subsector" = "EP_subsector")) |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

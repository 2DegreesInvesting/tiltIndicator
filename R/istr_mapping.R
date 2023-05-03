istr_mapping <- function(companies, ep_weo) {
  companies |>
    left_join(ep_weo, by = c("eco_sectors" = "ECO_sector"))
}

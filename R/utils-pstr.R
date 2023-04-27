pstr_new_dataset_companies <- function() {
  pstr_prepare_companies(pstr_raw_companies)
}

pstr_new_dataset_scenarios <- function() {
  pstr_prepare_scenario(list(weo = pstr_raw_weo_2022, ipr = pstr_raw_ipr_2022))
}

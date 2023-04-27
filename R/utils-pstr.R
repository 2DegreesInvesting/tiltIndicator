pstr_new_dataset_companies <- function() {
  pstr_prepare_companies(pstr_raw_companies)
}

pstr_new_dataset_scenarios <- function() {
  pstr_prepare_scenario(list(weo = pstr_new_weo_2022, ipr = pstr_new_ipr_2022))
}

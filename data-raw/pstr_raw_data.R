# Source: Tilman via slack
# https://2investinginitiative.slack.com/archives/C050VAQACC9/p1682460412787529?thread_ts=1682460115.359559&cid=C050VAQACC9

library(readr)
library(usethis)
devtools::load_all()

pstr_companies <- read_csv(extdata_path("pstr_raw_companies.csv")) |>
  pstr_prepare_companies()
use_data(pstr_companies, overwrite = TRUE)

pstr_scenarios <- pstr_prepare_scenario(list(
  pstr_raw_ipr_2022 = read_csv(extdata_path("pstr_raw_ipr_2022.csv")),
  pstr_raw_weo_2022 = read_csv(extdata_path("pstr_raw_weo_2022.csv"))
))
use_data(pstr_scenarios, overwrite = TRUE)

# Source: Tilman via slack
# https://2investinginitiative.slack.com/archives/C050VAQACC9/p1682460412787529?thread_ts=1682460115.359559&cid=C050VAQACC9

library(readr)
library(usethis)
devtools::load_all()

pstr_companies <- extdata_path("pstr_companies.csv") |>
  read_csv(col_types = cols(isic_4digit = col_character())) |>
  xstr_pivot_type_sector_subsector()
use_data(pstr_companies, overwrite = TRUE)

pstr_scenarios <- list(
  ipr = read_csv(extdata_path("pstr_ipr_2022.csv")),
  weo = read_csv(extdata_path("pstr_weo_2022.csv"))
) |>
  pstr_prepare_scenario()
use_data(pstr_scenarios, overwrite = TRUE)

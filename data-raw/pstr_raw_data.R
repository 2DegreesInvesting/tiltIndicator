# Source: Tilman via slack
# https://2investinginitiative.slack.com/archives/C050VAQACC9/p1682460412787529?thread_ts=1682460115.359559&cid=C050VAQACC9

library(here)
library(readr)
library(usethis)

pstr_raw_companies <- read_csv(here("data-raw/pstr_new/pstr_raw_companies.csv"))
use_data(pstr_raw_companies, overwrite = TRUE)

pstr_raw_ipr_2022 <- read_csv(here("data-raw/pstr_new/pstr_raw_ipr_2022.csv"))
use_data(pstr_raw_ipr_2022, overwrite = TRUE)

pstr_raw_weo_2022 <- read_csv(here("data-raw/pstr_new/pstr_raw_weo_2022.csv"))
use_data(pstr_raw_weo_2022, overwrite = TRUE)

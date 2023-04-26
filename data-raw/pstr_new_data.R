# Source: Tilman via slack
# https://2investinginitiative.slack.com/archives/C050VAQACC9/p1682460412787529?thread_ts=1682460115.359559&cid=C050VAQACC9

library(here)

pstr_new_companies <- here("data-raw/pstr_new/pstr_new_companies.csv") |>
  read_csv() |>
  glimpse()

pstr_new_ipr_2022 <- here("data-raw/pstr_new/pstr_new_ipr_2022.csv") |>
  read_csv() |>
  glimpse()

pstr_new_weo_2022 <- here("data-raw/pstr_new/pstr_new_weo_2022.csv") |>
  read_csv() |>
  glimpse()


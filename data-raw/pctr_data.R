library(dplyr)
library(readr)
library(here)
library(usethis)

devtools::load_all()

# Source: Tilman via tilt.indicator.product.carbon.tr-main_v2.zip at:
# https://github.com/2DegreesInvesting/tiltData/issues/200#issue-1623506353
pctr_ecoinvent_co2 <- here("data-raw/pctr/data_ecoinvent_co2.csv") |>
  read_csv(show_col_types = FALSE) |>
  select(all_of(pctr_ecoinvent_co2_crucial()))
use_data(pctr_ecoinvent_co2, overwrite = TRUE)

# Source: Tilman via tilt.indicator.product.carbon.tr-main_v2.zip at:
# https://github.com/2DegreesInvesting/tiltData/issues/200#issue-1623506353
pctr_companies <- here("data-raw/pctr/tilt_companies.csv") |>
  read_csv(show_col_types = FALSE) |>
  select(all_of(pctr_companies_crucial()))
use_data(pctr_companies, overwrite = TRUE)

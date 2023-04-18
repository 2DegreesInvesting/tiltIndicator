library(readr)
library(here)
library(usethis)

options(readr.show_col_types = FALSE)

istr_companies <- read_csv(here("data-raw", "istr", "istr_companies.csv"))
use_data(istr_companies, overwrite = TRUE)

istr_ep_weo <- read_csv(here("data-raw", "istr", "istr_ep_weo.csv"))
use_data(istr_ep_weo, overwrite = TRUE)

istr_weo_2022 <- read_csv(here("data-raw", "istr", "istr_weo_2022.csv"))
use_data(istr_weo_2022, overwrite = TRUE)

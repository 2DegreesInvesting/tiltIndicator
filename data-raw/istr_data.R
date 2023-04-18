library(readr)
library(here)
library(usethis)

istr_companies <- read_csv(here("data-raw", "istr", "istr_companies.csv"), show_col_types = FALSE)
use_data(istr_companies, overwrite = TRUE)

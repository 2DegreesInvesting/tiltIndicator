library(here)
library(readr)
library(usethis)

# The raw data comes from tiltIndicator#87, which includes pre-processing
ictr_inputs <- read_csv(here("data-raw", "ictr", "ictr_inputs.csv"), show_col_types = FALSE) |>
  select(all_of(ictr_inputs_crucial()))
use_data(ictr_inputs, overwrite = TRUE)

ictr_companies <- read_csv(here("data-raw", "ictr", "ictr_companies.csv"), show_col_types = FALSE) |>
  select(all_of(ictr_companies_crucial()))
use_data(ictr_companies, overwrite = TRUE)

library(here)
library(readr)
library(usethis)

# The raw data comes from tiltIndicator#170, which includes pre-processing
ictr_inputs <- read_csv(here("data-raw", "ictr", "ictr_inputs.csv"))
use_data(ictr_inputs, overwrite = TRUE)

ictr_companies <- read_csv(here("data-raw", "ictr", "ictr_companies.csv"))
use_data(ictr_companies, overwrite = TRUE)

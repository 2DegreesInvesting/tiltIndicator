library(usethis)
library(here)

ictr_inputs <- read.csv(here("data-raw", "ictr", "ictr_inputs.csv"))
use_data(ictr_inputs, overwrite = TRUE)

ictr_companies <- read.csv(here("data-raw", "ictr", "ictr_companies.csv"))
use_data(ictr_companies, overwrite = TRUE)

library(vroom)
library(here)
library(usethis)

# The raw data comes from tiltIndicator#87, which includes pre-processing
ictr_inputs <- vroom(here("data-raw", "ictr", "real_data", "ictr_inputs.csv"), show_col_types = FALSE) |>
  select(all_of(ictr_inputs_crucial()))
use_data(ictr_inputs, overwrite = TRUE)

ictr_companies <- vroom(here("data-raw", "ictr", "real_data", "ictr_companies.csv"), show_col_types = FALSE) |>
  select(all_of(ictr_companies_crucial()))
use_data(ictr_companies, overwrite = TRUE)

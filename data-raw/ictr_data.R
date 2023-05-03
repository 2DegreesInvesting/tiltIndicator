library(here)
library(readr)
library(usethis)

load_all()

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
ictr_inputs <- read_csv(here("data-raw", "ictr", "ictr_inputs.csv")) |>
  select(all_of(ictr_inputs_crucial()))
use_data(ictr_inputs, overwrite = TRUE)

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
ictr_companies <- read_csv(here("data-raw", "ictr", "ictr_companies.csv")) |>
  select(all_of(ictr_companies_crucial()))
use_data(ictr_companies, overwrite = TRUE)

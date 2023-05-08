library(here)
library(readr)
library(usethis)
devtools::load_all()

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
inputs <- read_csv(here("data-raw", "inputs.csv")) |>
  select(all_of(ictr_inputs_crucial()))

is_na_free <- !anyNA(inputs$input_co2_footprint)
stopifnot(is_na_free)
use_data(inputs, overwrite = TRUE)

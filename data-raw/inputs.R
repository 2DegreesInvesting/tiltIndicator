library(here)
library(readr)
library(usethis)
devtools::load_all()

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
inputs <- read_csv(here("data-raw", "inputs.csv")) |>
  select(all_of(c(
    "input_co2_footprint",
    "input_tilt_sector",
    "input_unit",
    "input_isic_4digit",
    "input_activity_uuid_product_uuid",
    "activity_uuid_product_uuid"
  )))

is_na_free <- !anyNA(inputs$input_co2_footprint)
stopifnot(is_na_free)
use_data(inputs, overwrite = TRUE)

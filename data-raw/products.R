library(dplyr)
library(readr)
library(here)
library(usethis)
devtools::load_all()

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
products <- here("data-raw", "products.csv") |>
  read_csv(show_col_types = FALSE, col_types = cols(isic_4digit = col_character())) |>
  select(all_of(c(
    "co2_footprint",
    "tilt_sector",
    "unit",
    "isic_4digit",
    "activity_uuid_product_uuid",
    "ei_activity_name"
  ))) |>
  # #390
  filter(row_number() == 1L,  .by = "activity_uuid_product_uuid")

use_data(products, overwrite = TRUE)

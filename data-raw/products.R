library(dplyr)
library(readr)
library(here)
library(usethis)
devtools::load_all()

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
products <- here("data-raw", "products.csv") |>
  read_csv(show_col_types = FALSE) |>
  select(all_of(products_crucial()))
use_data(products, overwrite = TRUE)

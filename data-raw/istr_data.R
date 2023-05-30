# TODO: Source of the data
library(usethis)
library(readr)
devtools::load_all()

istr_companies <- extdata_path("istr_companies.csv") |>
  read_csv()
use_data(istr_companies, overwrite = TRUE)

istr_inputs <- extdata_path("istr_inputs.csv") |>
  read_csv(col_types = cols(input_isic_4digit = col_character())) |>
  xstr_pivot_type_sector_subsector()
use_data(istr_inputs, overwrite = TRUE)

# TODO: Create XSTR Scenarios dataset
istr_scenarios <- pstr_scenarios
use_data(istr_scenarios, overwrite = TRUE)

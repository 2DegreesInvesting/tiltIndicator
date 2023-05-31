# Source: @Tilmon via:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/347#issue-1717975337
library(usethis)
library(readr)
devtools::load_all()

istr_companies <- extdata_path("istr_companies.csv") |>
  read_csv()
use_data(istr_companies, overwrite = TRUE)

istr_inputs <- extdata_path("istr_inputs.csv") |>
  read_csv(col_types = cols(input_isic_4digit = col_character())) |>
  rename(weo_product = "input_weo_product", weo_flow = "input_weo_flow", ipr_sector = "input_ipr_sector", ipr_subsector = "input_ipr_subsector") |>
  xstr_pivot_type_sector_subsector()
use_data(istr_inputs, overwrite = TRUE)

istr_scenarios <- pstr_scenarios
use_data(istr_scenarios, overwrite = TRUE)

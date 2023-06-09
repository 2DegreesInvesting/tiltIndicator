# Source: Tilman via slack
# TODO: Add source

library(readr)
library(usethis)
devtools::load_all()

xstr_scenarios <- list(
  ipr = read_csv(extdata_path("str_ipr_targets.csv")),
  weo = read_csv(extdata_path("str_weo_targets.csv"))
) |>
  xstr_prepare_scenario()
use_data(xstr_scenarios, overwrite = TRUE)

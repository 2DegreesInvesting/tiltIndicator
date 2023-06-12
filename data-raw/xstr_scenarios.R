# Source:
# https://drive.google.com/drive/u/0/folders/15AsbEhET2WvU0z2dFhyKfvZF9jQHPuvP

library(readr)
library(usethis)
devtools::load_all()

xstr_scenarios <- list(
  ipr = read_csv(extdata_path("str_ipr_targets.csv")),
  weo = read_csv(extdata_path("str_weo_targets.csv"))
) |>
  xstr_prepare_scenario()
use_data(xstr_scenarios, overwrite = TRUE)

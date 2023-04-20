# https://github.com/2DegreesInvesting/tiltIndicator/issues/160
# See data_prep_v1.zip

library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)
library(fs)
devtools::load_all()

options(readr.show_col_types = FALSE)

data_path <- function(...) {
  path_home("Downloads", "data_prep_v1", "pstr_pctr_data", ...)
}

files <- data_path(c(
    "pctr_companies.csv",
    "pctr_ecoinvent_co2.csv",
    "pstr_companies.csv",
    "pstr_ipr_2022.csv",
    "pstr_weo_2022.csv"
))

real <- lapply(files, read_csv) |>
  setNames(path_ext_remove(path_file(files)))

real$pctr_companies

# usethis::use_data(companies, overwrite = TRUE)

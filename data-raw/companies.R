library(here)
library(usethis)

# Source:
# https://github.com/2DegreesInvesting/tiltIndicator/issues/167#issuecomment-1527223646
companies <- read_csv(here("data-raw", "companies.csv")) |>
  select(all_of(c(
    "activity_uuid_product_uuid",
    "clustered",
    "company_id",
    "unit"
  )))
use_data(companies, overwrite = TRUE)

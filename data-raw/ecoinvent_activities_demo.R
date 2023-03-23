# Source: Tilman via https://github.com/2DegreesInvesting/tiltData/issues/200
# Privacy: Public based on a meeting on 2023-03-22
options(readr.show_col_types = FALSE)

path <- pctr_path("input_data", "ecoinvent_activities.csv")
ecoinvent_activities <- read_csv(path)
ecoinvent_activities_demo <- head(ecoinvent_activities, 20L)
use_data(ecoinvent_activities_demo, overwrite = TRUE)

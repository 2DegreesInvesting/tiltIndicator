# Source: Tilman via https://github.com/2DegreesInvesting/tiltData/issues/200
# Privacy: Public based on a meeting on 2023-03-22
options(readr.show_col_types = FALSE)
mvp_sample_dataset_demo <- pctr_path("input_data", "MVP_sample_dataset.csv")
use_data(mvp_sample_dataset_demo, overwrite = TRUE)

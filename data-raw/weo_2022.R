weo_2022 <- tibble::tribble(
  ~publication,                             ~scenario, ~region,        ~category, ~product,                               ~flow,    ~unit, ~year,  ~value, ~reductions,
  "World Energy Outlook 2021",            "Stated Policies Scenario", "world", "co2 combustion",  "Total", "Road passenger light duty vehicle", "mt co2",  2020, 2787.63,           0,
  "World Energy Outlook 2021", "Net Zero Emissions by 2050 Scenario", "world", "co2 combustion",  "Total", "Road passenger light duty vehicle", "mt co2",  2030, 1626.32,       41.66,
  "World Energy Outlook 2021", "Net Zero Emissions by 2050 Scenario", "world", "co2 combustion",  "Total", "Road passenger light duty vehicle", "mt co2",  2040,  546.54,       80.39,
  "World Energy Outlook 2021", "Net Zero Emissions by 2050 Scenario", "world", "co2 combustion",  "Total", "Road passenger light duty vehicle", "mt co2",  2050,   84.56,       96.97,
  "World Energy Outlook 2021",            "Stated Policies Scenario", "world", "co2 combustion",  "Total",                    "Iron and steel", "mt co2",  2020, 2590.57,           0,
  "World Energy Outlook 2021", "Net Zero Emissions by 2050 Scenario", "world", "co2 combustion",  "Total",                    "Iron and steel", "mt co2",  2030,  194.53,       31.35,
  "World Energy Outlook 2021", "Net Zero Emissions by 2050 Scenario", "world", "co2 combustion",  "Total",                    "Iron and steel", "mt co2",  2040, 10122.9,       66.86,
  "World Energy Outlook 2021", "Net Zero Emissions by 2050 Scenario", "world", "co2 combustion",  "Total",                    "Iron and steel", "mt co2",  2050, 7426.46,       91.49
)

usethis::use_data(weo_2022, overwrite = TRUE)

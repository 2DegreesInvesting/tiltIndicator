# Source: Linda
# styler: off
companies <- tibble::tribble(
  ~company_id,        ~company_name,               ~products,                      ~sector,                     ~subsector,
            1,      "Peasant Peter",                "screws", "steel_metal_transformation",    "bending_steels_and_metals",
            2,      "Peasant Peter",       "aluminium_alloy",               "steel_metals",             "aluminium_alloys",
            3,      "Peasant Peter",      "ultrafilstration",                       "cars", "vehicle_maintenance_products",
            4,       "Peasant Paul",           "frozen_food",                "frozen_food",                "cheese_slicer",
            5,  "Tom's Car Company",                  "oils",                       "cars",                  "automobiles",
            6,  "Tom's Car Company",                 "bolts", "steel_metal_transformation",    "bending_steels_and_metals",
            7, "Screwdriver Expert",                "chucks", "steel_metal_transformation",     "boring_steels_and_metals",
            8, "Screwdriver Expert",       "adaptator_plate", "steel_metal_transformation",     "boring_steels_and_metals",
            9,  "John Meier's Cars", "disinfection_products",                       "cars", "vehicle_maintenance_products",
            10,  "John Meier's Cars",      "ultrafilstration",                       "cars", "vehicle_maintenance_products"
)
# styler: on

usethis::use_data(companies, overwrite = TRUE)

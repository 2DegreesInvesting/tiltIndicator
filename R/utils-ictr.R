#' Toy `ictr_inputs`
#'
#' @examples
#' ictr_toy_inputs()
#' ictr_toy_inputs(unit = NULL)
#' ictr_toy_inputs(new = 1)
#' @noRd
ictr_toy_inputs <- function(input_co2 = 1, input_sector = "a", unit = "u", ...) {
  tibble::tibble(
    input_co2 = input_co2,
    input_sector = input_sector,
    unit = unit,
    ...
  )
}

ictr_toy_inputs2 <- function(input_co2 = 1,
                             input_sector = "a",
                             unit = "metric ton*km",
                             activity_product_uuid = "0a242b09-772a-5edf-8e82-9cb4ba52a258_ae39ee61-d4d0-4cce-93b4-0745344da5fa",
                             ei_activity = "transport, freight, lorry 7.5-16 metric ton, EURO3",
                             ...) {
  tibble::tibble(
    input_co2 = input_co2,
    input_sector = input_sector,
    unit = unit,
    activity_product_uuid = activity_product_uuid,
    ei_activity = ei_activity,
    ...
  )
}

ictr_toy_companies <- function() {
  # styler: off
  tibble::tribble(
    ~company_id,                                                      ~activity_product_uuid,                                                     ~ei_activity,  ~unit,
    "fleischerei-stiefsohn_00000005219477-001", "edd290d2-a5b0-56ec-aaf3-ad71ce5f9403_095528f2-b554-4cfb-9dc8-764b50bcbd7b",      "transport, passenger car, large size, natural gas, EURO 4",   "km",
    "pecheries-basques_fra316541-00101", "d2c0844e-6e5b-52a3-802c-b1a9c162b9b1_fc458a34-8eed-427a-a5e0-c8e930422250",                 "market for mineral supplement, for beef cattle",   "kg",
    "pecheries-basques_fra316541-00101", "abdb78ee-ddb9-5552-9c4c-ed5b8b2ea11c_5a337107-6bdb-4280-84d4-15a4993c51c9",                                         "citric acid production",   "kg",
    "pecheries-basques_fra316541-00101", "16e1dc41-2793-521c-b4c9-811cbaa6d36a_7655baa9-ac88-4f13-a1e7-77bd2059a7a6",                               "sodium ethyl xanthate production",   "kg",
    "hoche-butter-gmbh_deu422723-693847001", "8496d0e1-83eb-5a8d-8290-3394bb282f7e_1c2b2eb7-cdc9-4375-9fee-feb975ba4f64",                                          "stone meal production",   "kg",
    "vicquelin-espaces-verts_fra697272-00101", "ae3ff8b8-2fca-5654-a7c6-1dcaf31d7c32_d3a29af5-314a-4659-a574-6bfd53a6bde0",                                     "hydroformylation of butene",   "kg",
    "vicquelin-espaces-verts_fra697272-00101", "1636162a-eac4-59da-9430-96ad54cbdafa_6eb8dc11-5ac4-4538-a1f1-95463b640ea5", "market for energy and auxilliary inputs, metal working factory",   "kg",
    "vicquelin-espaces-verts_fra697272-00101", "1899920a-4828-5d6d-b601-6ccf625a2b15_ca8ec222-fdaa-4c97-849e-130f1256593f",                           "market for used lorry, 16 metric ton", "unit",
    "bst-procontrol-gmbh_00000005104947-001", "85ba1478-38fa-5c5a-86a7-51e4a3615705_3d0a8c4e-af1f-4164-9961-40d201fa5645",                       "polysulfide production, sealing compound",   "kg"
  )
  # styler: on
}

ictr_inputs_crucial <- function() {
  crucial_in_ictr_score_activities <- c(
    "input_co2",
    "input_sector",
    "unit"
  )

  crucial_in_ictr_score_companies <- c(
    "activity_product_uuid",
    "ei_activity"
  )

  c(crucial_in_ictr_score_activities, crucial_in_ictr_score_companies)
}

ictr_companies_crucial <- function() {
  c(
    "activity_product_uuid",
    "company_id",
    "ei_activity",
    "unit"
  )
}

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

demo_ictr_data <- function(input_co2, unit = "kg", sector = "xyz", ...){
  tibble::tibble(input_co2 = input_co2, unit = unit, sector = sector, ...)
}

ictr_inputs_crucial <- function() {
  crucial_in_ictr_score_activities <- c(
    "input_co2",
    "input_sector",
    "unit"
  )

  crucial_in_ictr_score_companies <- c(
    "activity_uuid_product_uuid"
  )

  c(crucial_in_ictr_score_activities, crucial_in_ictr_score_companies)
}

ictr_companies_crucial <- function() {
  c(
    "activity_uuid_product_uuid",
    "company_id",
    "unit"
  )
}

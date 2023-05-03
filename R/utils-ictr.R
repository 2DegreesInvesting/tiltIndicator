ictr_inputs_crucial <- function() {
  crucial_in_ictr_score_activities <- c(
    "input_co2_footprint",
    "input_tilt_sector",
    "input_unit",
    "input_isic_4digit_sector"
  )

  crucial_in_ictr_at_company_level <- c(
    "activity_uuid_product_uuid"
  )

  c(crucial_in_ictr_score_activities, crucial_in_ictr_at_company_level)
}

ictr_companies_crucial <- function() {
  c(
    "activity_uuid_product_uuid",
    "company_id",
    "unit"
  )
}

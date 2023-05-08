pctr_ecoinvent_co2_crucial <- function() {
  crucial_in_pctr_at_product_level <- c(
    "co2_footprint",
    "tilt_sector",
    "unit",
    "isic_4digit"
  )

  crucial_in_pctr_at_company_level <- c(
    "activity_uuid_product_uuid",
    "ei_activity_name"
  )

  c(crucial_in_pctr_at_product_level, crucial_in_pctr_at_company_level)
}

pctr_at_company_level_crucial <- function() {
  c(
    "activity_product_uuid",
    "ei_activity",
    "score_all",
    "score_unit",
    "score_unit_sec",
    "unit"
  )
}

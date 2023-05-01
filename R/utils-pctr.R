pctr_ecoinvent_co2_crucial <- function() {
  crucial_in_pctr_at_product_level <- c(
    "co2_footprint",
    "sec",
    "unit"
  )

  crucial_in_pctr_at_company_level <- c(
    "activity_product_uuid",
    "ei_activity"
  )

  c(crucial_in_pctr_at_product_level, crucial_in_pctr_at_company_level)
}

pctr_companies_crucial <- function() {
  c(
    "activity_product_uuid",
    "company_id",
    "ei_activity",
    "unit"
  )
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

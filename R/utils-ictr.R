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

column_sum_checker <- function(sum_all = 1, sum_unit = 1, sum_sector = 1, sum_unit_sec = 1) {
  tibble::tibble(
    sum_all = sum_all,
    sum_unit = sum_unit,
    sum_sector = sum_sector,
    sum_unit_sec = sum_unit_sec
  )
}

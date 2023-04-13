#' Toy
#'
#' @examples
#' pctr_toy_pctr_ecoinvent_co2()
#' pctr_toy_pctr_ecoinvent_co2(unit = NULL)
#' pctr_toy_pctr_ecoinvent_co2(new = 1)
#' @noRd
pctr_toy_pctr_ecoinvent_co2 <- function(sec = "Transport",
                                        unit = "metric ton*km",
                                        co2_footprint = 4, ...) {
  tibble::tibble(
    sec = sec,
    unit = unit,
    co2_footprint = co2_footprint,
    ...
  )
}

pctr_ecoinvent_co2_crucial <- function() {
  crucial_in_pctr_score_activities <- c(
    "co2_footprint",
    "sec",
    "unit"
  )

  crucial_in_pctr_score_companies <- c(
    "activity_product_uuid",
    "ei_activity"
  )

  c(crucial_in_pctr_score_activities, crucial_in_pctr_score_companies)
}

pctr_companies_crucial <- function() {
  c(
    "activity_product_uuid",
    "company_id",
    "ei_activity",
    "unit"
  )
}

pctr_score_companies_crucial <- function() {
  c(
    "activity_product_uuid",
    "ei_activity",
    "score_all",
    "score_unit",
    "score_unit_sec",
    "unit"
  )
}

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

#' Crucial columns for pctr_score_companies
pctr_score_companies_crucial <- function() {
  c(
    "unit",
    "score_unit_sec",
    "ei_activity",
    "activity_product_uuid",
    "score_all",
    "score_unit"
  )
}

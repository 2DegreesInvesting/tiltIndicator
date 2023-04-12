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

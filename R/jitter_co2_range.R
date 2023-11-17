jitter_co2_range <- function(data) {
  crucial <- c("grouped_by", "risk_category", find_co2_footprint(data))
  check_crucial_names(data, crucial)

  data
}

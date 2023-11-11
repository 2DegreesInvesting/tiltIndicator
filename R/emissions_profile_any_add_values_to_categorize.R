#' Add `values_to_categorize` FIXME find a better name
#'
#' @param data FIXME point to tiltToyData. A "co2" dataset containing products or upstream-products.
#'
#' @family pre-processing helpers
#'
#' @return FIXME add test. The input dataset with the additional column `values_to_cagegorize`.
#' @export
#'
#' @examples
#' # FIXME add examples
emissions_profile_any_add_values_to_categorize <- function(data) {
  add_rank <- function(data, .by) {
    if (identical(.by, "all")) .by <- NULL
    mutate(
      data,
      values_to_categorize = rank_proportion(.data[[find_co2_footprint(data)]]),
      .by = all_of(.by)
    )
  }

  benchmarks <- set_names(epa_benchmarks(), flat_benchmarks())
  map_df(benchmarks, ~ add_rank(data, .x), .id = "grouped_by")
}

#' Polish output at company level
#'
#' @param data The output of `xstr*()` functions.
#'
#' @family helpers
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' out <- pstr(pstr_companies, pstr_scenarios)
#' out |> xstr_separate_grouped_by()
#'
#' out <- istr(istr_companies, istr_scenarios, istr_inputs)
#' out |> xstr_separate_grouped_by()
xstr_separate_grouped_by <- function(data) {
  separate_wider_delim(
    data,
    cols = "grouped_by",
    delim = "_",
    names = c("type", "scenario", "year")
  )
}

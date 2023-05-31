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
#' library(dplyr, warn.conflicts = FALSE)
#'
#' out <- pstr(slice(pstr_companies, 1), pstr_scenarios)
#' out |> xstr_polish_output_at_copmany_level()
#'
#' out <- istr(slice(istr_companies, 1), istr_scenarios, istr_inputs)
#' out |> xstr_polish_output_at_copmany_lxevel()
xstr_polish_output_at_copmany_level <- function(data) {
  separate_wider_delim(
    data,
    cols = "grouped_by",
    delim = "_",
    names = c("type", "scenario", "year")
  )
}

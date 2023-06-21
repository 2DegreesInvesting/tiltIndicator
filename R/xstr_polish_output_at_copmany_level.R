#' Polish output at company level
#'
#' @param data The output of `xstr*()` functions.
#'
#' @family post-processing helpers
#'
#' @return A dataframe.
#' @export
#'
#' @examples
#' pstr(pstr_companies, xstr_scenarios) |>
#'   xstr_polish_output_at_company_level()
#'
#' istr(istr_companies, xstr_scenarios, istr_inputs) |>
#'   xstr_polish_output_at_company_level()
xstr_polish_output_at_company_level <- function(data) {
  out <- separate_wider_delim(
    data,
    cols = "grouped_by",
    delim = "_",
    names = c("type", "scenario", "year")
  )
  out
}

if_all_na_is_first_else_not_na <- function(x) {
  if (all(is.na(x))) is_first(x) else !is.na(x)
}

is_first <- function(x) {
  seq_along(x) == 1L
}

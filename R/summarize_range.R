#' Summarize the range of a column by groups
#'
#' This function is a shortcut to `dplyr::summarize(data, min = min(x), max =
#' max(x))`.
#'
#' @param data A dataframe.
#' @param col Unquoted expression giving the name of a column in `data`.
#' @inheritParams dplyr::summarize
#' @inheritParams base::min
#'
#' @seealso [dplyr::summarize()]
#'
#' @return A dataframe:
#'   * The rows come from the underlying groups.
#'   * The columns come from the grouping keys plus the new columns `min` and
#'   `max`.
#'   * The groups are dropped.
#'
#' @family helpers
#'
#' @export
#'
#' @examples
#' library(tibble)
#'
#' data <- tibble(x = 1:4, group = c(1, 1, 2, 2))
#' data
#'
#' summarize_range(data, x, .by = group)
summarize_range <- function(data, col, .by = NULL, na.rm = FALSE) {
  summarize(
    data,
    min = min({{ col }}, na.rm = na.rm),
    max = max({{ col }}, na.rm = na.rm),
    .by = {{ .by }}
  )
}

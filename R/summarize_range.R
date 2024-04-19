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
#' summarize_range(data, "x", .by = group)
summarize_range <- function(data, col, .by = NULL, na.rm = FALSE) {
  UseMethod("summarize_range")
}

#' @export
summarize_range.data.frame <- function(data, col, .by = NULL, na.rm = FALSE) {
  msg <- "Passing `col` as a symbol is superseded. Use the string 'col' instead."
  .col <- rlang::quo_get_expr(enquo(col))
  if (is.symbol(.col)) {
    warn(msg)
    col <- rlang::as_name(.col)
  }

  summarize(
    data,
    min = min(.data[[col]], na.rm = na.rm),
    max = max(.data[[col]], na.rm = na.rm),
    .by = {{ .by }}
  )
}

# TODO: Move to tiltIndicator
# TODO check that .x is a list
# TODO check that .by is a named list
# TODO check the relationship between the names of .x and .by
#' @export
summarize_range.list <- function(data, col, .by = NULL, na.rm = FALSE) {
  out <- vector("list", length = length(data))
  names(out) <- names(data)
  for (i in names(data)) {
    out[[i]] <- summarize_range(
      data[[i]],
      col = col,
      .by = all_of(.by[[i]]),
      na.rm = na.rm
    )
  }

  out
}

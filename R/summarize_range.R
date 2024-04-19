#' Summarize the range of a column by groups
#'
#' This funciton is a generic that includes support for dataframes and lists of
#' dataframes. For dataframes, this function is a shortcut to
#' `dplyr::summarize(data, min = min(x), max = max(x))`. For lists of dataframes
#' that idea applies applies to each element of the list.
#'
#' @param data A dataframe or a list of dataframes.
#' @param col Unquoted expression giving the name of a column in `data`.
#' @param .by A vector or list of vectors depending on whether `data` is a
#' dataframe or list of dataframes, respective. For details see `.by` in
#' [dplyr::summarize()].
#' @inheritParams dplyr::summarize
#' @inheritParams base::min
#'
#' @seealso [dplyr::summarize()]
#'
#' @return A dataframe or a list of dataframes:
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
#' data <- tibble(x = 1:4, group = letters[c(1, 1, 2, 2)])
#' data
#'
#' summarize_range(data, "x", .by = "group")
#'
#' list <- split(data, data$group)
#' list
#'
#' summarize_range(list, col = "x", .by = list(a = "group", b = "group"))
summarize_range <- function(data, col, .by = NULL, na.rm = FALSE) {
  UseMethod("summarize_range")
}

#' @export
summarize_range.data.frame <- function(data, col, .by = NULL, na.rm = FALSE) {
  .col <- quo_get_expr(enquo(col))
  if (is.symbol(.col)) col <- as_name(.col)

  summarize(
    data,
    min = min(.data[[col]], na.rm = na.rm),
    max = max(.data[[col]], na.rm = na.rm),
    .by = {{ .by }}
  )
}

#' @export
summarize_range.list <- function(data, col, .by = NULL, na.rm = FALSE) {
  if (!is_named(.by)) abort("`.by` must be named.")

  out <- vector("list", length = length(data))
  names(out) <- names(data)
  for (i in names(data)) {
    check_by(data[[i]], .by[[i]])

    out[[i]] <- summarize_range(
      data[[i]],
      col = {{ col }},
      .by = all_of(.by[[i]]),
      na.rm = na.rm
    )
  }

  out
}

check_by <- function(data, .by) {
  if (!is_empty(setdiff(.by, names(data)))) {
    abort("Each value of `.by` must be a column in the corresponding `data`.")
  }
}

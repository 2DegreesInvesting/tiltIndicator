#' Access a column via an internal alias it's 'also known as'
#'
#' Accessing columns this way makes the code more maintainable by avoiding
#' column names that are likely to change.
#'
#' @param x A character giving the internal 'also known as' of a column name.
#' @param dictionary A dataframe like [example_dictionary()].
#' @keywords internal
#' @export
#' @return A character.
#' @examples
#' aka("id")
aka <- memoise(function(x, dictionary = example_dictionary()) {
  check_aka(x, dictionary)

  dictionary |>
    filter(.data$aka == x) |>
    slice(1) |>
    pull(.data$column)
})

check_aka <- function(x, dictionary) {
  valid <- sort(unique(dictionary$aka))
  if (!x %in% valid) {
    abort(c(glue("'{x}' is invalid."), i = "See `example_dictionary()`"))
  }

  invisible(x)
}

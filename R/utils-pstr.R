#' Lowercase characters in data
#'
#' @param data A data frame.
#'
#' @return A [data.frame] with the values of its character content lower cased.
#'
#' @examples # TODO
#' @noRd
lowercase_characters <- function(data) {
  mutate(data, across(where(is.character), tolower))
}

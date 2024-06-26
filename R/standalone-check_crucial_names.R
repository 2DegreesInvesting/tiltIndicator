# ---
# repo: 2DegreesInvesting/tiltIndicator
# file: standalone-check_crucial_names.R
# last-updated: 2024-06-15
# license: https://unlicense.org
# imports: [rlang, glue]
# ---

#' @importFrom rlang is_named
#' @importFrom rlang abort
#' @importFrom glue glue
NULL

#' Check if a named object contains expected names
#'
#' Based on fgeo.tool::check_crucial_names()
#'
#' @param x A named object.
#' @param expected_names String; expected names of `x`.
#'
#' @return Invisible `x`, or an error with informative message.
#'
#' Adapted from: https://github.com/RMI-PACTA/r2dii.match/blob/main/R/check_crucial_names.R
#'
#' @examples
#' x <- c(a = 1)
#' check_crucial_names(x, "a")
#' try(check_crucial_names(x, "bad"))
#' @noRd
check_crucial_names <- function(x, expected_names) {
  stopifnot(is_named(x))
  stopifnot(is.character(expected_names))

  ok <- all(unique(expected_names) %in% names(x))
  if (!ok) {
    abort_missing_names(sort(setdiff(expected_names, names(x))))
  }

  invisible(x)
}

abort_missing_names <- function(missing_names) {
  abort(
    "missing_names",
    message = glue(
      "Must have missing names:
      {paste0('`', missing_names, '`', collapse = ', ')}"
    )
  )
}

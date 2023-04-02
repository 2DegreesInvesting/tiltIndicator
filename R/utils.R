#' Get path to MVPs
#'
#' The minimal-viable-product (MVP) of each indicator was originally developed
#' in an .Rmd file that we gradually refactored towards production. They are
#' stored in inst/extdata/mvp/ in their original form -- except for minimal
#' changes such as redirection of inputs and outputs to avoid leaking private
#' data.
#'
#' @param path Name of file.
#' @param pattern A regular expression of filenames to match. If NULL all
#'   available files are returned. listed.
#'
#' @examples
#' mvp_paths()
#' try(mvp_path("inexistent.file"))
#' @noRd
mvp_path <- function(path) {
  system.file(
    "extdata", "mvp", path,
    package = "tiltIndicator", mustWork = TRUE
  )
}

mvp_paths <- function(pattern = NULL) {
  dir <- system.file("extdata", "mvp", package = "tiltIndicator")
  list.files(dir, pattern = pattern)
}

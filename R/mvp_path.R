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
#' @family developer-oriented functions
#'
#' @return `r class(mvp_paths())`
#' @export
#'
#' @examples
#' mvp_paths()
#' mvp_path("pstr.Rmd")
#' try(mvp_path())
#' try(mvp_path("inexistent.file"))
mvp_path <- function(path) {
  system.file(
    "extdata", "mvp", path, package = "tiltIndicator", mustWork = TRUE
  )
}

#' @rdname mvp_path
#' @export
mvp_paths <- function(pattern = NULL) {
  dir <- system.file("extdata", "mvp", package = "tiltIndicator")
  list.files(dir, pattern = pattern)
}

#' Given an .Rmd file returns a list of it's .csv outputs
#'
#' This function helps in the early steps of refactoring code from an .Rmd file
#' into a function. With relatively save, minimal changes to the .Rmd file you
#' can generate testable output, that you can later use to do more risky
#' refactoring steps.
#'
#' @inheritDotParams rmarkdown::render
#' @param path Character. Path to an .Rmd file.
#'
#' @family developer-oriented functions
#'
#' @return A named list where each element is one .csv output at the working
#'   directory of the .Rmd file.
#' @export
#'
#' @examples
#' rmd <- system.file("extdata/mtcars.Rmd", package = "tiltIndicator")
#' writeLines(readLines(rmd))
#'
#' wrap_rmd(rmd)
#'
#' # You may pass `...` to `rmarkdown::render()`, e.g. `params`
#' wrap_rmd(rmd, params = list(input1 = head(mtcars)))
wrap_rmd <- function(path, ...) {
  tmp_dir <- withr::local_tempdir()
  tmp_rmd <- fs::path(tmp_dir, fs::path_file(path))
  fs::file_copy(path, tmp_rmd)

  withr::local_dir(tmp_dir)
  rmarkdown::render(tmp_rmd, quiet = TRUE, ...)

  csv <- fs::dir_ls(tmp_dir, regexp = "[.]csv")
  nms <- fs::path_ext_remove(fs::path_file(csv))
  out <- lapply(csv, function(x) readr::read_csv(x, show_col_types = FALSE))
  out <- stats::setNames(out, nms)
  out
}

#' Given an .Rmd file returns a list of all objects in the rendering environment
#'
#' @inheritDotParams rmarkdown::render
#' @param path Character. Path to an .Rmd file.
#'
#' @keywords internal
#'
#' @return A named list with one element per object in the rendering
#'   environment.
#' @export
#'
#' @examples
#' path <- system.file("extdata", "mtcars.Rmd", package = "tiltIndicator")
#' writeLines(readLines(path))
#'
#' render_to_list(path)
#'
#' # You may pass `...` to `rmarkdown::render()`, e.g. `params`
#' render_to_list(path, params = list(input1 = head(mtcars)))
render_to_list <- function(path, ...) {
  tmp_dir <- withr::local_tempdir()
  tmp_rmd <- fs::path(tmp_dir, fs::path_file(path))
  fs::file_copy(path, tmp_rmd)

  withr::local_dir(tmp_dir)

  e <- withr::local_environment(new.env())
  rmarkdown::render(tmp_rmd, envir = e, quiet = TRUE, knit_root_dir = tmp_dir, ...)
  as.list(e)
}

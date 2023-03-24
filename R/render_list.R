#' Given an .Rmd file returns a list of all objects in the rendering environment
#'
#' @inheritDotParams rmarkdown::render
#' @param path Character. Path to an .Rmd file.
#'
#' @family developer-oriented functions
#'
#' @return A named list with one element per object in the rendering
#'   environment.
#' @export
#'
#' @examples
#' path <- system.file("extdata", "mtcars.Rmd", package = "tiltIndicator")
#' writeLines(readLines(path))
#'
#' render_list(path)
#'
#' # You may pass `...` to `rmarkdown::render()`, e.g. `params`
#' render_list(path, params = list(input1 = head(mtcars)))
render_list <- function(path, ...) {
  e <- withr::local_environment(new.env())
  rmarkdown::render(path, envir = e, quiet = TRUE, ...)
  as.list(e)
}

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
#' Create a task list that you can paste on a GitHub issue and follow up
#'
#' @return Character. A checklist you can paste on a GitHub issue.
#' @keywords internal
#'
#' @export
#' @examples
#' use_refactoring_checklist()

use_refactoring_checklist <- function() {
  glue::glue("
  - [ ] Confirm the data is public.
  - [ ] Add mvp .Rmd.
  - [ ] Redirect `here` to access inputs.
  - [ ] Render and assess viability. If viable contine else ask for changes.
  - [ ] `use_article()`. with mvp .Rmd as child document.
  - [ ] Document authorship in DESCRIPTION, mvp, and article.
  - [ ] Snapshot important objects in the rendering environment or the mvp.
  - [ ] In data-raw/ `use_data()`.
  - [ ] `use_r('*_data')`.
  - [ ] Reuse data in .Rmd files.
  - [ ] Polish and publish article.
  - [ ] Bump version.
  - [ ] Announce new Article on Slack.
  - [ ] Discuss the API with the author.
  - [ ] Refactor: Extract functions in place.
  - [ ] Refactor: Move functions to R/ and address R CMD check issues.
  - [ ] Reorganize documentation (e.g. use man/fragments) and flag TODO.
  - [ ] Update CODEOWNWERS.
  - [ ] Ask authors to help with documentation.
  - [ ] Snapshot each feature and remove the general mvp-level snapshot.
  - [ ] Refactor: Move mvp to article.
  ")
}


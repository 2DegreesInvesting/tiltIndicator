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
  - [ ] Add the mvp .Rmd.
  - [ ] Redirect `here` to access inputs.
  - [ ] Render and assess viability. If not viable ask for changes.
  - [ ] `use_article()`. Reuse the mvp .Rmd as a `child` document.
  - [ ] Document authorship in DESCRIPTION, mvp, and article.
  - [ ] Snapshot important objects in the rendering environment or the mvp.
  - [ ] `use_data()`.
  - [ ] Document data minimally to avoid R CMD issues and to show an example.
  - [ ] Reuse data in the mvp .Rmd.
  - [ ] Update _pkgdown.yaml.
  - [ ] Polish and publish article.
  - [ ] Bump version.
  - [ ] Announce new Article on Slack.
  - [ ] Refactor: Extract functions in place.
  - [ ] Refactor: Move functions to R/ and document @author.
  - [ ] Refactor: Address R CMD check issues.
  - [ ] Update _pkgdown.yaml.
  - [ ] Ask authors to document data and functions, then prune the article.
  - [ ] Snapshot each feature and remove the general mvp-level snapshot.
  - [ ] Move mvp to article.
  - [ ] Add basic characterization tests and discuss with the author.
  - [ ] Discuss the API with the author.
  - [ ] DRY code across mvps.
  - [ ] DRY documentation (e.g. via man/fragments).
  - [ ] Update CODEOWNWERS.
  ")
}

#' Create a task list that you can paste on a GitHub issue and follow up
#'
#' @param indicator Character. The indicator abbreviation, e.g. for
#'   "product-carbon-transition-risk" use "pstr".
#'
#' @return Character. A checklist you can paste on a GitHub issue.
#' @family internals
#'
#' @export
#' @examples
#' use_refactoring_checklist("pstr")
use_refactoring_checklist <- function(indicator) {
  split <- unlist(strsplit(indicator, split = "-"))
  ind <- paste(substr(split, 1L, 1L), collapse = "")

  glue::glue("
  - [ ] `use_version()`.
  - [ ] Confirm the data is public.
  - [ ] Add inst/extdata/mvp/{indicator}.Rmd.
  - [ ] Document authorship in */{indicator}.Rmd.
  - [ ] `use_article('{indicator}')` with mvp as child document.
  - [ ] Document authorship in DESCRIPTION, article, and mvp.
  - [ ] Redirect inputs, e.g.: `here <- {ind}_path`.
  - [ ] Snapshot useful objects from the .Rmd environment via `render_to_list()`.
  - [ ] Update NEWS.md.
  - [ ] `use_version()`.
  - [ ] Refactor: `use_data()` and ask the author to document it.
  - [ ] Refactor: Use package data.
  - [ ] Refactor: Extract functions in the .Rmd.
  - [ ] Refactor: Move functions to R/ and ask the author to document it.
  - [ ] Update NEWS.md.
  - [ ] `use_version()`.
  ")
}

#' Create a task list that you can paste on a GitHub issue and follow up
#'
#' @param indicator Character. Hyphen-separated string giving the full name of
#'   the indicator, e.g. "product-carbon-transition-risk".
#'
#' @return Character. A checklist you can paste on a GitHub issue.
#' @family developer-oriented functions
#'
#' @export
#' @examples
#' use_indicator_issue("product-sector-transition-risk")
use_indicator_issue <- function(indicator = "indicator") {
  split <- unlist(strsplit(indicator, split = "-"))
  ind <- paste(substr(split, 1L, 1L), collapse = "")

  glue::glue("
  - [ ] Confirm the data is public.
  - [ ] Add inst/extdata/mvp/{indicator}.Rmd.
  - [ ] Document authorship in */{indicator}.Rmd.
  - [ ] `use_article('{indicator}')` with mvp as child document.
  - [ ] Document authorship in DESCRIPTION, article, and mvp.
  - [ ] Redirect inputs, e.g.: `here <- {ind}_path`.
  - [ ] Snapshot useful objects from the .Rmd environment via `render_list()`.
  - [ ] Refactor: `use_data()` and ask the author to document it.
  - [ ] Refactor: Use package data.
  - [ ] Refactor: Extract functions in the .Rmd.
  - [ ] Refactor: Move functions to R/ and ask the author to document it.
  ")
}

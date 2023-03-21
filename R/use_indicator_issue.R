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
#' use_indicator_issue("product-carbon-transition-risk")
use_indicator_issue <- function(indicator = "indicator") {
  split <- unlist(strsplit(indicator, split = "-"))
  ind <- paste(substr(split, 1L, 1L), collapse = "")

  glue::glue("
  - [ ] Add inst/extdata/mvp/{indicator}.Rmd.
  - [ ] Document authorship in */{indicator}.Rmd
  - [ ] Document authorship DESCRIPTION.
  - [ ] Redirect inputs to read from private data dir: `here <- {ind}_path`.
  - [ ] Redirect outputs to write to 'obj.csv': `write_csv(obj, 'obj.csv')`.
  - [ ] Confirm rendering */{indicator}.Rmd doesn't leak private data.
  - [ ] Create `{ind}_obj()` to return 'obj' from `wrap_rmd('*/{ind}.Rmd')`.
  - [ ] Snapshot `{ind}_obj()` via `test_dir('/path/to/private/directory/')`.
  - [ ] Document `{ind}_obj()`.
  - [ ] Refactor `{ind}_obj()`.
  ")
}

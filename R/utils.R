#' Get path to child extdata/
#'
#' @param path Character. Path to a directory in inst/extdata/.
#' @keywords internal
#' @export
#' @examples
#' extdata_path("")
#' list.files(extdata_path(""), recursive = TRUE)
extdata_path <- function(path) {
  system.file("extdata", path, package = "tiltIndicator", mustWork = TRUE)
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

#' Throws an error if `data` has NA values in the co2 column
#'
#' @param data A dataframe/tibble
#'
#' @examples
#' data <- tibble::tibble(input_co2_footprint = c(1, 4))
#' stop_if_any_missing_input_co2_footprint(data)
#'
#' data <- tibble::tibble(input_co2_footprint = c(1, NA))
#' try(stop_if_any_missing_input_co2_footprint(data))
#' @noRd
stop_if_any_missing_input_co2_footprint <- function(data) {
  if (anyNA(data$input_co2_footprint)) {
    stop("Each `input_co2_footprint` must not be missing.")
  }
  invisible(data)
}

cols_at_all_levels <- function() {
  c("companies_id", "grouped_by", "risk_category")
}

cols_at_product_level <- function() {
  c(cols_at_all_levels(), "clustered", "activity_uuid_product_uuid")
}

relocate_cols_at_product_level <- function(data) {
  data |>
    relocate(
      all_of(cols_at_product_level()),
      ends_with("activity_uuid_product_uuid")
    )
}

cols_at_company_level <- function() {
  c(cols_at_all_levels(), "value")
}

document_value <- function() {
  paste0(
    "At product level, a dataframe with at least columns ",
    toString(cols_at_all_levels()), ". ",
    "At company level, a dataframe with at least columns ",
    toString(cols_at_company_level()), "."
  )
}
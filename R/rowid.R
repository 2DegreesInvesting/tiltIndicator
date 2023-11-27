#' Generic
#' @export
#' @keywords internal
rowid <- function() {
  UseMethod("rowid")
}

#' Generic
#' @export
#' @keywords internal
co2_rowid <- function() {
  UseMethod("co2_rowid")
}

check_rowid <- function(x) {
  check_reserved_name(x, reserved = c(rowid(), co2_rowid()))
  check_unique_rowid(x)
}

hint_specify_rowid <- function() {
  glue(
    "Do you need to create a table-specific name, e.g. `companies_{rowid()}`?"
  )
}

check_unique_rowid <- function(x) {
  rowid <- extract_rowid_names(x)

  missing <- !any(length(rowid) > 0)
  if (missing) {
    return(invisible(x))
  }

  duplicated <- any(duplicated(rowid))
  if (duplicated) abort_duplicated_rowid()

  invisible(x)
}

extract_rowid_names <- function(x) {
  out <- unlist(lapply(x, extract_name, glue("{rowid()}$")))
  unname(out[nzchar(out)])
}

abort_duplicated_rowid <- function() {
  abort(c(
    glue("The name of the `*{rowid()}` column must be different in each table."),
    i = hint_specify_rowid()
  ))
}

document_optional_rowid <- function() {
  paste0(
    "Any column in the input datasets ending with `*", rowid(), "` is also ",
    "passed as is to the output at product level. The exception is any column ",
    "named exactly `", rowid(), "`", " or `co2_rowid` -- which are reserved names ",
    "and throws an error. Note this feature makes no sense at company level ",
    "because potentially multiple rows in the input datasets are summarized into ",
    "a single row in the output at company level."
  )
}

check_reserved_name <- function(x, reserved = c(rowid(), co2_rowid())) {
  if (has_reserved_name(x, reserved)) {
    abort_reserved_name(reserved, hint = hint_specify_rowid())
  }

  invisible(x)
}

has_reserved_name <- function(x, reserved) {
  any(unlist(lapply(x, hasName, reserved)))
}

abort_reserved_name <- function(reserved, hint) {
  abort(
    c(glue("The name `{reserved}` is reserved."), i = hint),
    class = "reserved_name"
  )
}

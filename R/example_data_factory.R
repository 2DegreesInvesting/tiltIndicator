#' Fabricate functions that construct example datasets
#'
#' @export
#' @keywords internal
#' @examples
#' data <- tibble::tibble(x = 1, y = 1)
#' example_data <- example_data_factory(data)
#'
#' example_data()
#'
#' col <- "x"
#' example_data(!!col := 1:2)
example_data_factory <- function(data) {
  force(data)

  function(...) {
    new <- tibble(...)
    old <- as.list(data)
    add <- setdiff(names(old), names(new))
    as_tibble(append(new, old[add]))
  }
}

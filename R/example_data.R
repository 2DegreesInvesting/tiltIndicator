example_data_factory <- function(data) {
  function(...) {
    new <- tibble(...)
    old <- as.list(data)
    add <- setdiff(names(old), names(new))
    as_tibble(append(new, old[add]))
  }
}

#' Create example companies
#'
#' @param ... Passed to [tibble()].
#' @keywords internal
#' @export
#' @return A [tibble()].
#' @examples
#' example_companies()
example_companies <- example_data_factory(data = example_data("companies"))
example_scenarios <- example_data_factory(data = example_data("scenarios"))
example_products <- example_data_factory(data = example_data("products"))
example_inputs <- example_data_factory(data = example_data("inputs"))

example_data <- function(x, dictionary = example_dictionary()) {
  out <- dictionary |>
    filter(.data$table == x) |>
    select("column", "value")
  as_tibble(as.list(set_names(out$value, out$column)))
}

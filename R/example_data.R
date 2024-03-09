example_data_factory <- function(data) {
  force(data)

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
example_products <- example_data_factory(data = example_co2("products"))
example_inputs <- example_data_factory(data = example_co2("inputs"))

example_data <- function(x, dictionary = example_dictionary()) {
  out <- dictionary |>
    filter(.data$table == x) |>
    select("column", "value")
  as_tibble(as.list(set_names(out$value, out$column)))
}

example_co2 <- function(co2) {
  mutate(example_data(co2), across(matches(aka("co2footprint")), as.numeric))
}

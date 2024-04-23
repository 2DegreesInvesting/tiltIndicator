#' Exclude columns matching a pattern and the resulting duplicates
#'
#' @param data A dataframe.
#' @inheritParams tidyselect::matches
#'
#' @return A dataframe excluding the matching columns and duplicates.
#' @export
#' @family composable friends
#'
#' @examples
#' library(tibble)
#'
#' # Excludes columns along with all its duplicates
#' data <- tibble(x = 1, y = 1:2)
#' data
#' data |> exclude("y")
#'
#' # Columns are matched as a regular expression
#' data <- tibble(x = 1, yz = 1:2, zy = 1)
#' data
#' data |> exclude("y")
#' data |> exclude("y$")
#'
#'
#'
#' # With a 'tilt_profile' excludes at both levels in a single step
#'
#' product <- company <- tibble(companies_id = 1, y = "a", z = 1)
#' result <- tilt_profile(nest_levels(product, company))
#' result |> class()
#' result
#'
#' out <- result |> exclude("y")
#' out |> unnest_product()
#' out |> unnest_company()
exclude <- function(data, match) {
  UseMethod("exclude")
}

#' @export
exclude.data.frame <- function(data, match) {
  out <- select(data, -matches(match))

  no_match <- rlang::is_empty(names_diff(data, out))
  if (no_match) {
    return(out)
  } else {
    distinct(out)
  }
}

#' @export
exclude.tilt_profile <- function(data, match) {
  product <- exclude(unnest_product(data), match)
  company <- exclude(unnest_company(data), match)
  result <- nest_levels(product, company)
  tilt_profile(result)
}

names_diff <- function(x, y) {
  setdiff(names(x), names(y))
}

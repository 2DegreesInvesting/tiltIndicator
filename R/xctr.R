#' Calculate input (or product) carbon transition risk
#'
#' These functions calculate the input (or product) carbon transition risk. The
#' process is the same. What varies is the `co2` dataset.
#'
#' ### Depracated
#'
#' The `ictr*()` and `pctr*()` functions are now deprecated. Use the `xctr*()`
#' functions instead.
#'
#' ### Input carbon transition risk (ICTR)
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' ### Product carbon transition risk (PCTR)
#'
#' ```{r child=extdata_path("child/intro-pctr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [companies].
#' @param co2 A dataframe like [inputs].
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#' @param data A dataframe. The output at product level.
#'
#' @family XCTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- companies
#'
#' # ICTR
#' inputs <- inputs
#'
#' companies |>
#'   xctr_at_product_level(co2 = inputs)
#'
#' companies |>
#'   xctr_at_product_level(co2 = inputs) |>
#'   xctr_at_company_level()
#'
#' # Same
#' companies |> xctr(co2 = inputs)
#'
#' # PCTR
#' products <- products
#'
#' companies |>
#'   xctr_at_product_level(co2 = products)
#'
#' companies |>
#'   xctr_at_product_level(co2 = products) |>
#'   xctr_at_company_level()
#'
#' # Same
#' companies |> xctr(co2 = products)
xctr <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  companies |>
    xctr_at_product_level(co2, low_threshold, high_threshold) |>
    xctr_at_company_level()
}

#' @export
#' @rdname xctr
xctr_at_company_level <- function(data) {
  benchmarks <- xctr_combined_benchmarks()

  data |>
    # FIXME: Instead rename downstream
    rename(company_id = "companies_id") |>
    # FIXME: Instead handle data in long format
    xctr_pivot_grouped_by_to_score() |>
    xctr_at_company_level_impl(benchmarks) |>
    xctr_polish_output_at_company_level()
}

xctr_at_company_level_impl <- function(data, benchmarks) {
  # For each company show all risk levels even if the share is 0.
  template <- tibble(
    company_id = rep(unique(data$company_id), each = 3),
    score = rep(c("high", "medium", "low"), length(unique(data$company_id))),
  )

  .benchmarks <- map(benchmarks, ~ add_share(data, .x))

  list(template) |>
    append(.benchmarks) |>
    reduce(left_join, by = c("company_id", "score")) |>
    mutate(
      across(starts_with("share_"), na_to_0_if_not_all_is_na),
      .by = "company_id"
    )
}

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

xctr_combined_benchmarks <- function() {
  xctr_benchmarks() |>
    lapply(paste, collapse = "_") |>
    unlist() |>
    unique()
}

stop_if_col_to_rank_has_missing_values <- function(co2) {
  if (anyNA(co2[[col_to_rank(co2)]])) {
    stop(col_to_rank(co2), " can't have missing values.")
  }
}

stop_if_isic_class_not_char <- function(co2, column) {
  if (any(grepl(column, names(co2)))) {
    stopifnot(is.character(unlist(select(co2, contains(column)))))
  }
}

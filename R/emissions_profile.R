#' Calculate input (or product) carbon transition risk
#'
#' These functions calculate the input (or product) carbon transition risk. The
#' process is the same. What varies is the `co2` dataset.
#'
#' ### Deprecated
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
#'
#' @family XCTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' emissions_profile(companies, products)
#' emissions_profile(companies, products) |> unnest_product()
#' emissions_profile(companies, products) |> unnest_company()
#'
#' emissions_profile_upstream(companies, inputs)
emissions_profile <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  product <- xctr_at_product_level(companies, co2, low_threshold, high_threshold)
  company <- xctr_at_company_level(product)
  nest_levels(product, company)
}

#' @export
#' @rdname emissions_profile
emissions_profile_upstream <- emissions_profile

xctr_company <- function(data) {
  warn_product_and_company_level_functions_are_now_deprecated()

  with_value <- data |>
    select("companies_id", "grouped_by", "risk_category") |>
    filter(!is.na(.data$risk_category)) |>
    add_count(.data$companies_id, .data$grouped_by) |>
    mutate(
      value = .data$n / sum(.data$n),
      .by = c("companies_id", "grouped_by")
    ) |>
    select(-"n")

  all_unmatched <- identical(nrow(with_value), 0L)
  if (all_unmatched) {
    return(empty_company_output_from(data$companies_id))
  }

  unmatched <- setdiff(unique(data$companies_id), unique(with_value$companies_id))
  some_unmatched <- length(unmatched) > 0L
  if (some_unmatched) {
    with_value <- bind_rows(with_value, empty_company_output_from(unmatched))
  }

  levels <- risk_category_levels()
  with_value |>
    group_by(.data$companies_id, .data$grouped_by) |>
    mutate(risk_category = factor(.data$risk_category, levels = levels)) |>
    expand(.data$risk_category) |>
    filter(!is.na(.data$risk_category)) |>
    left_join(with_value, by = join_by("companies_id", "grouped_by", "risk_category")) |>
    ungroup() |>
    mutate(
      value = na_to_0_if_not_all_is_na(.data$value),
      .by = c("companies_id", "grouped_by")
    ) |>
    # Hack #285. FIXME: Explore why this happens
    summarize(
      value = sum(.data$value),
      .by = c("companies_id", "grouped_by", "risk_category")
    ) |>
    polish_output(cols_at_company_level())
}

pstr_company <- xctr_company

#' @export
#' @rdname deprecated
istr_at_company_level <- xctr_at_company_level

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

empty_company_output_from <- function(companies_id) {
  tibble(
    companies_id = unique(companies_id),
    grouped_by = NA_character_,
    risk_category = NA_character_,
    value = NA_real_
  )
}

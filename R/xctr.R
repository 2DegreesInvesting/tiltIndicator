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
  with_value <- data |>
    select("companies_id", "grouped_by", "risk_category") |>
    filter(!is.na(.data$risk_category)) |>
    add_count(.data$companies_id, .data$grouped_by) |>
    mutate(
      value = .data$n / sum(.data$n),
      .by = c("companies_id", "grouped_by")
    ) |>
    select(-"n")

  if (identical(nrow(with_value), 0L)) {
    return(
      empty_output_at_company_level(
        companies_id = unique(data$companies_id),
        grouped_by = grouped_by(data, data$grouped_by)
      )
    )
  }

  levels <- risk_category_levels()
  out <- with_value |>
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
    )

  if (anyNA(data$risk_category)) {
    unmatched <- filter(data, is.na(.data$risk_category))
    out <- bind_rows(
      out,
      empty_output_at_company_level(
        companies_id = unique(unmatched$companies_id),
        grouped_by = grouped_by(data, unmatched$grouped_by)
      )
    )
  }

  out |>
    xstr_prune_unmatched_products()
}

#' @rdname pstr
#' @export
pstr_at_company_level <- xctr_at_company_level
#' @rdname istr
#' @export
istr_at_company_level <- xctr_at_company_level

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

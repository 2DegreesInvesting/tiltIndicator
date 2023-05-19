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
  tmp <- select(data, "companies_id", "grouped_by", "risk_category")
  with_value <- tmp |>
    filter(!is.na(.data$risk_category)) |>
    add_count(.data$companies_id, .data$grouped_by) |>
    mutate(
      value = .data$n / sum(.data$n),
      .by = c("companies_id", "grouped_by")
    ) |>
    select(-all_of("n"))

  if (identical(nrow(with_value), 0L)) {
    ids <- unique(data$companies_id)
    .grouped_by <- grouped_by(data, tmp$grouped_by)
    out <- empty_output_at_company_level(ids, .grouped_by)

    return(out)
  }

  levels <- risk_category_levels()
  out <- with_value |>
    group_by(.data$companies_id, .data$grouped_by) |>
    mutate(risk_category = factor(.data$risk_category, levels = levels)) |>
    expand(.data$risk_category) |>
    filter(!is.na(.data$risk_category)) |>
    left_join(with_value, by = join_by("companies_id", "grouped_by", "risk_category")) |>
    ungroup()
  out <- out |>
    mutate(
      value = na_to_0_if_not_all_is_na(.data$value),
      .by = c("companies_id", "grouped_by")
    )
  out <- out |>
    # Hack #285
    summarize(
      value = sum(.data$value),
      .by = c("companies_id", "grouped_by", "risk_category")
    )

  if (anyNA(tmp$risk_category)) {
    unmatched <- filter(tmp, is.na(.data$risk_category))
    ids <- unique(unmatched$companies_id)
    .grouped_by <- grouped_by(data, unmatched$grouped_by)

    tmp <- tidyr::expand_grid(
      companies_id = ids,
      grouped_by = .grouped_by,
      risk_category = risk_category_levels(),
      value = NA_real_
    )

    out <- bind_rows(out, tmp)
  }

  out
}

empty_output_at_company_level <- function(companies_id, grouped_by) {
  expand_grid(
    companies_id = companies_id,
    grouped_by = grouped_by,
    risk_category = risk_category_levels(),
    value = NA_real_
  )
}

grouped_by <- function(data, grouped_by) {
  if (is_xctr(data)) {
    grouped_by <- flat_benchmarks()
  }
  grouped_by
}

# FIXME: Retire pstr_at_company_level
#' @rdname pstr
#' @export
pstr_at_company_level <- xctr_at_company_level
# FIXME: Retire istr_at_company_level
#' @rdname istr
#' @export
istr_at_company_level <- xctr_at_company_level

na_to_0_if_not_all_is_na <- function(x) {
  if (all(is.na(x))) {
    return(x)
  }
  replace_na(x, 0)
}

xctr_ptype_at_company_level <- function(companies_id = character(0)) {
  grouped_by <- flat_benchmarks()
  risk_category <- risk_category_levels()
  value <- NA_real_

  out <- expand_grid(companies_id, grouped_by, risk_category, value)
  relocate(out, all_of(cols_at_company_level()))
}

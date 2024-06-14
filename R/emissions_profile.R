#' Calculate the indicator "emissions profile"
#'
#' ```{r child=extdata_path("child/intro-emissions_profile.Rmd")}
#' ```
#'
#' @param companies,co2 `r document_dataset()`.
#' @param low_threshold A numeric value to segment low and medium emission
#'   profile products.
#' @param high_threshold A numeric value to segment medium and high emission
#'   profile products.
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @template example-emissions_profile
emissions_profile <- function(companies,
                              co2,
                              low_threshold = 1 / 3,
                              high_threshold = 2 / 3) {
  product <- emissions_profile_any_at_product_level(companies, co2, low_threshold, high_threshold)
  company <- epa_at_company_level(product) |>
    insert_row_with_na_in_risk_category()

  tilt_profile(nest_levels(product, company))
}

#' @export
#' @rdname emissions_profile_upstream
emissions_profile_upstream <- emissions_profile


#' Insert row with NA in risk category
#'
#' @param data A dataframe
#'
#' @return A dataframe
#' @export
#' @keywords internal
insert_row_with_na_in_risk_category <- function(data) {
  levels <- c(risk_category_levels(), NA)
  data |>
    mutate(has_na = anyNA(.data$risk_category), .by = "grouped_by") |>
    filter(!.data$has_na) |>
    distinct(.data$companies_id, .data$grouped_by) |>
    dplyr::bind_cols(tibble::tibble(risk_category = NA_character_, value = 0)) |>
    bind_rows(data) |>
    mutate(risk_category = factor(.data$risk_category, levels)) |>
    arrange(.data$companies_id, .data$grouped_by, .data$risk_category) |>
    mutate(risk_category = as.character(.data$risk_category))
}

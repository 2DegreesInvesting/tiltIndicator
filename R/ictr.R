#' Calculate the ICTR indicator
#'
#' ```{r child=extdata_path("child/intro-ictr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [ictr_companies].
#' @param co2 A dataframe like [ictr_inputs].
#' @param low_threshold A numeric value to segment low and medium transition
#'   risk products.
#' @param high_threshold A numeric value to segment medium and high transition
#'   risk products.
#' @param data A dataframe. The output at product level.
#'
#' @family ICTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- ictr_companies
#' co2 <- ictr_inputs
#'
#' # Product level
#' companies |>
#'   ictr_at_product_level(co2)
#'
#' # Company level
#' companies |>
#'   ictr_at_product_level(co2) |>
#'   ictr_at_company_level()
#'
#' # Same
#' ictr(companies, co2)
ictr <- function(companies, co2, low_threshold = 0.3, high_threshold = 0.7) {
  ictr_check(companies, co2)

  product_level1 <- companies |>
    ictr_at_product_level(co2, low_threshold, high_threshold)

  product_level1 |>
    ictr_at_company_level()
}

#' @rdname ictr
#' @export
ictr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 0.3,
                                  high_threshold = 0.7) {
  benchmarks <- list("all", "unit", "sec", c("unit", "sec"))
  scored <- co2 |>
    # FIXME: All other columns use the form
    #     `mutate(data, x = f(x))`
    # But this column uses the form
    #     `mutate(data, x = f(y))`
    # So here I rename y to x so I can use the same form for all columns
    rename(sec = "input_tilt_sector", unit = "input_unit") |>
    xctr_add_ranks(x = "input_co2_footprint", benchmarks) |>
    rename(input_tilt_sector = "sec", input_unit = "unit") |>
    ictr_add_scores(low_threshold, high_threshold)

  out <- left_join(
    companies,
    scored,
    by = "activity_uuid_product_uuid",
    relationship = "many-to-many"
  )

  out |>
    xctr_pivot_score_to_grouped_by() |>
    xctr_rename_at_product_level() |>
    relocate(all_of(cols_at_all_levels()))
}

#' @rdname ictr
#' @export
ictr_at_company_level <- function(data) {
  data |>
    # FIXME: Instead rename downstream
    rename(company_id = "companies_id") |>
    # FIXME: Instead handle data in long format
    xctr_pivot_grouped_by_to_score() |>
    xctr_at_company_level(c("all", "unit", "sector", "unit_sec")) |>
    xctr_polish_output_at_company_level()
}

ictr_add_scores <- function(ecoinvent_input, low_threshold, high_threshold) {
  ## assign scores to position within percentile distribution
  ecoinvent_input %>%
    ## for all input products
    mutate(
      score_all = case_when(
        perc_all < low_threshold ~ "low",
        perc_all >= low_threshold & perc_all < high_threshold ~ "medium",
        perc_all >= high_threshold ~ "high"
      )
    ) |>
    ## for products with same unit
    mutate(
      score_unit = case_when(
        perc_unit < low_threshold ~ "low",
        perc_unit >= low_threshold & perc_unit < high_threshold ~ "medium",
        # FIXME: Should be high_threshold
        perc_unit >= low_threshold ~ "high"
      )
    ) |>
    ## for products with same sector
    mutate(
      score_sector = case_when(
        perc_sec < low_threshold ~ "low",
        perc_sec >= low_threshold & perc_sec < high_threshold ~ "medium",
        perc_sec >= low_threshold ~ "high"
      )
    ) |>
    ## for products with same unit and sector
    mutate(
      score_unit_sec = case_when(
        perc_unit_sec < low_threshold ~ "low",
        perc_unit_sec >= low_threshold & perc_unit_sec < high_threshold ~ "medium",
        perc_unit_sec >= high_threshold ~ "high",
      )
    )
}

ictr_check <- function(companies, co2) {
  stopifnot(hasName(companies, "company_id"))
  stopifnot(hasName(co2, "input_co2_footprint"))
  stop_if_any_missing_input_co2_footprint(co2)
}

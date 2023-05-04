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

  companies |>
    ictr_at_product_level(co2, low_threshold, high_threshold) |>
    ictr_at_company_level()
}

#' @rdname ictr
#' @export
ictr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 0.3,
                                  high_threshold = 0.7) {
  benchmarks <- list("all", "unit", "tilt_sec", "isic_sec", c("unit", "tilt_sec"), c("unit", "isic_sec"))
  scored <- co2 |>
    # FIXME: All other columns use the form
    #     `mutate(data, x = f(x))`
    # But this column uses the form
    #     `mutate(data, x = f(y))`
    # So here I rename y to x so I can use the same form for all columns
    rename(tilt_sec = "input_tilt_sector", unit = "input_unit", isic_sec = "input_isic_4digit_sector") |>
    xctr_add_ranks(x = "input_co2_footprint", benchmarks) |>
    rename(input_tilt_sector = "tilt_sec", input_unit = "unit", input_isic_4digit_sector = "isic_sec") |>
    ictr_add_scores(low_threshold, high_threshold)

  out <- left_join(
    companies,
    scored,
    by = "activity_uuid_product_uuid",
    relationship = "many-to-many"
  )

  xctr_polish_output_at_product_level(out)
}

#' @rdname ictr
#' @export
ictr_at_company_level <- function(data) {
  xctr_at_company_level(data, c("all", "unit", "tilt_sector", "unit_tilt_sec", "isic_sector", "unit_isic_sec"))
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
    ## for input products with same unit
    mutate(
      score_unit = case_when(
        perc_unit < low_threshold ~ "low",
        perc_unit >= low_threshold & perc_unit < high_threshold ~ "medium",
        perc_unit >= high_threshold ~ "high"
      )
    ) |>
    ## for input products with same tilt sector
    mutate(
      score_tilt_sector = case_when(
        perc_tilt_sec < low_threshold ~ "low",
        perc_tilt_sec >= low_threshold & perc_tilt_sec < high_threshold ~ "medium",
        perc_tilt_sec >= high_threshold ~ "high"
      )
    ) |>
    ## for input products with same unit and tilt sector
    mutate(
      score_unit_tilt_sec = case_when(
        perc_unit_tilt_sec < low_threshold ~ "low",
        perc_unit_tilt_sec >= low_threshold & perc_unit_tilt_sec < high_threshold ~ "medium",
        perc_unit_tilt_sec >= high_threshold ~ "high",
      )
    ) |>
    ## for input products with same isic sector
    mutate(
      score_isic_sector = case_when(
        perc_isic_sec < low_threshold ~ "low",
        perc_isic_sec >= low_threshold & perc_isic_sec < high_threshold ~ "medium",
        perc_isic_sec >= high_threshold ~ "high"
      )
    ) |>
    ## for input products with same unit and isic sector
    mutate(
      score_unit_isic_sec = case_when(
        perc_unit_isic_sec < low_threshold ~ "low",
        perc_unit_isic_sec >= low_threshold & perc_unit_isic_sec < high_threshold ~ "medium",
        perc_unit_isic_sec >= high_threshold ~ "high",
      )
    )
}

ictr_check <- function(companies, co2) {
  stopifnot(hasName(companies, "company_id"))
  stopifnot(hasName(co2, "input_co2_footprint"))
  stop_if_any_missing_input_co2_footprint(co2)
}

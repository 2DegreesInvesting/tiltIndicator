#' Calculate the PCTR indicator
#'
#' ```{r child=extdata_path("child/intro-pctr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [pctr_companies].
#' @param co2 A dataframe like [pctr_ecoinvent_co2].
#' @inheritParams ictr
#'
#' @family PCTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- pctr_companies
#' co2 <- pctr_ecoinvent_co2
#'
#' # Product level
#' companies |>
#'   pctr_at_product_level(co2)
#'
#' # Company level
#' companies |>
#'   pctr_at_product_level(co2) |>
#'   pctr_at_company_level()
#'
#' # Same
#' pctr(companies, co2)
pctr <- function(companies, co2, low_threshold = 0.3, high_threshold = 0.7) {
  pctr_check(companies)

  companies |>
    pctr_at_product_level(co2, low_threshold, high_threshold) |>
    pctr_at_company_level()
}

#' @rdname pctr
#' @export
pctr_at_product_level <- function(companies,
                                  co2,
                                  low_threshold = 0.3,
                                  high_threshold = 0.7) {
  benchmarks <- list("all", "unit", c("unit", "sec"))
  scored <- co2 |>
    rename(sec = "tilt_sector") |>
    xctr_add_ranks(x = "co2_footprint", .by = benchmarks) |>
    rename(tilt_sector = "sec") |>
    pctr_add_scores(low_threshold, high_threshold)

  out <- left_join(
    companies,
    scored,
    by = "activity_uuid_product_uuid",
    relationship = "many-to-many"
  )

  xctr_polish_output_at_product_level(out)
}

#' @rdname pctr
#' @export
pctr_at_company_level <- function(data, benchmarks = c("all", "unit", "unit_sec")) {
  xctr_at_company_level(data, benchmarks)
}

pctr_add_scores <- function(ecoinvent_ranks, low_threshold, high_threshold) {
  ecoinvent_ranks %>%
    mutate(
      score_all = case_when(
        perc_all < low_threshold ~ "low",
        perc_all >= low_threshold & perc_all < high_threshold ~ "medium",
        perc_all >= high_threshold ~ "high"
      )
    ) |>
    # for products with same unit
    mutate(
      score_unit = case_when(
        perc_unit < low_threshold ~ "low",
        perc_unit >= low_threshold & perc_unit < high_threshold ~ "medium",
        # FIXME: Should be high_threshold?
        perc_unit >= low_threshold ~ "high"
      )
    ) |>
    # for products with same unit and sector
    mutate(
      score_unit_sec = case_when(
        perc_unit_sec < low_threshold ~ "low",
        perc_unit_sec >= low_threshold & perc_unit_sec < high_threshold ~ "medium",
        perc_unit_sec >= high_threshold ~ "high",
      )
    )
}

pctr_check <- function(companies) {
  stopifnot(hasName(companies, "company_id"))
}

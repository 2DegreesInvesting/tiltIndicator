#' Calculate the ISTR indicator
#'
#' ```{r child=extdata_path("child/intro-istr.Rmd")}
#' ```
#'
#' @param companies A dataframe like [istr_companies].
#' @param scenario A dataframe like [istr_weo_2022].
#' @param mapper A dataframe like [istr_ep_weo].
#' @param data A dataframe. The output at product level.
#'
#' @family ISTR functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @examples
#' companies <- istr_companies
#' scenario <- istr_weo_2022
#' mapper <- istr_ep_weo
#'
#' # Product level
#' companies |>
#'   istr_at_product_level(scenario, mapper)
#'
#' # Company level
#' companies |>
#'   istr_at_product_level(scenario, mapper) |>
#'   istr_at_company_level(companies)
#'
#' # Same
#' istr(companies, scenario, mapper)
istr <- function(companies, scenario, mapper) {
  companies |>
    istr_at_product_level(scenario, mapper) |>
    istr_at_company_level(companies)
}

#' @rdname istr
#' @export
istr_at_product_level <- function(companies, scenario, mapper) {
  companies |>
    istr_mapping(mapper) |>
    istr_add_reductions(scenario) |>
    istr_add_transition_risk()
}

#' @rdname istr
#' @export
istr_at_company_level <- function(data, companies) {
  n_products_per_companies <- companies |>
    group_by(.data$companies_id, .data$company_name) |>
    summarise(total_products_per_company = n())

  with_transition_risk2 <- data |>
    left_join(
      # FIXME Join by company_id
      n_products_per_companies,
      by = c("companies_id", "company_name"),
      # TODO: ASK Linda to confirm we want this relationship
      relationship = "many-to-many"
    )

  useful_cols <- c(
    "companies_id",
    "company_name",
    "transition_risk",
    "total_products_per_company",
    "scenario",
    "year"
  )
  out <- with_transition_risk2 |>
    select(all_of(all_of(useful_cols))) |>
    group_by(.data$companies_id, .data$company_name, .data$transition_risk, .data$scenario, .data$year) |>
    summarise(score_aggregated = (n() / .data$total_products_per_company * 100)) |>
    # FIXME? Do we really want grouped output?
    group_by(.data$companies_id, .data$company_name, .data$transition_risk, .data$scenario, .data$year) |>
    # FIXME: Do we really want distinct_all()? It's superseded by
    # distinct(across(everything() ... and also here it seems we can use just
    # `distinct()`. See ?distinct_all(), ?distinct(), and also this reprex:
    # https://gist.github.com/maurolepore/45c899b9429f5d48004e2e127257cc29
    distinct_all()

  xstr_polish_output(out)
}

istr_mapping <- function(companies, ep_weo) {
  companies |>
    left_join(ep_weo, by = c("eco_sectors" = "ECO_sector"))
}

istr_add_reductions <- function(companies, weo_2022) {
  companies |>
    # left_join(ep_weo, by = c("eco_sectors" = "ECO_sector")) |>
    left_join(weo_2022, by = c("weo_product_mapper" = "product", "weo_flow_mapper" = "flow"))
}

istr_add_transition_risk <- function(with_reductions) {
  with_reductions |>
    mutate(
      transition_risk = case_when(
        reductions <= 30 ~ "low",
        reductions > 30 & reductions <= 70 ~ "medium",
        reductions >= 70 ~ "high",
        TRUE ~ "no_sector",
      )
    )
}

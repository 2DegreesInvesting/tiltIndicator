#' Calculate the indicator "sector profile"
#'
#' ```{r child=extdata_path("child/intro-sector_profile.Rmd")}
#' ```
#'
#' @param companies,scenarios `r document_dataset()`.
#' @param low_threshold A numeric value to segment low and medium reduction
#'   targets.
#' @param high_threshold A numeric value to segment medium and high reduction
#'   targets.
#'
#' @family main functions
#'
#' @return `r document_value()`
#'
#' @export
#'
#' @template example-sector_profile
sector_profile <- function(companies,
                           scenarios,
                           low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                           high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  warn_custom_threshold(low_threshold)
  warn_custom_threshold(high_threshold)

  product <- sector_profile_at_product_level(companies, scenarios, low_threshold, high_threshold)
  company <- epa_at_company_level(product) |>
    insert_row_with_na_in_risk_category()

  nest_levels(product, company)
}

warn_custom_threshold <- function(x) {
  type <- gsub("^(.*)_.*$", "\\1", deparse(substitute(x)))
  default <- unique(x) %in% thresholds()[[type]]
  if (!default) {
    rlang::warn(glue::glue("Using a non-default value of `{type}_threshold`: {x}."))
  }

  invisible(x)
}

thresholds <- function() {
  tibble::tribble(
    ~year, ~low, ~high,
     2030,  1/9,   2/9,
       NA,  1/3,   2/3,
  )
}

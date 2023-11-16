cols_at_all_levels <- function() {
  c(cols_by(), "risk_category")
}

cols_by <- function() {
  c("companies_id", "grouped_by")
}

cols_at_product_level <- function() {
  c(cols_at_all_levels(), "profile_ranking", aka("cluster"), aka("uid"))
}

cols_at_company_level <- function() {
  c(cols_at_all_levels(), "value")
}

cols_na_at_product_level <- function() {
  not_na <- c("companies_id", "clustered")
  setdiff(cols_at_product_level(), not_na)
}

cols_na_at_company_level <- function() {
  not_na <- c("companies_id")
  setdiff(cols_at_company_level(), not_na)
}


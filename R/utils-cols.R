cols_at_all_levels <- function() {
  c(cols_by(), "risk_category")
}

cols_by <- function() {
  c("companies_id", "grouped_by")
}

cols_at_product_level <- function() {
  c(cols_at_all_levels(), aka("cluster"), aka("uid"))
}

cols_at_company_level <- function() {
  c(cols_at_all_levels(), "value")
}

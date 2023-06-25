x_carbon <- function(companies, co2, low_threshold = 1 / 3, high_threshold = 2 / 3) {
  product <- xctr_at_product_level(companies, co2, low_threshold, high_threshold)
  company <- xctr_at_company_level(product)
  nest_levels(product, company)
}

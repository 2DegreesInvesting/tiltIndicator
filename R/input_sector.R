input_sector <- function(companies,
                         scenarios,
                         inputs,
                         low_threshold = ifelse(scenarios$year == 2030, 1 / 9, 1 / 3),
                         high_threshold = ifelse(scenarios$year == 2030, 2 / 9, 2 / 3)) {
  product <- istr_at_product_level(
    companies, scenarios, inputs, low_threshold, high_threshold
  )
  company <- xctr_at_company_level(product)
  nest_levels(product, company)
}

pctr_path <- function(...) {
  fs::path(data_dir(), "product-carbon-tr", ...)
}

pctr_company_scores <- function() {
  file <- pctr_path("output_data", "mvp_pctr_output.csv")
  readr::read_csv(file)
}

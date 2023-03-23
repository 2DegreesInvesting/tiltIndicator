pctr_company_scores <- function(..., mvp = mvp_path("product-carbon-transition-risk.Rmd")) {
  dots <- rlang::quos_auto_name(rlang::enquos(...))
  params <- rlang::set_names(list(...), names(dots))
  wrap_rmd(path = mvp, params = params)[["company_scores"]]
}

test_that("capture outputs", {
  mvp <- mvp_path("product-sector-transition-risk.Rmd")
  out <- wrap_rmd(mvp)
})

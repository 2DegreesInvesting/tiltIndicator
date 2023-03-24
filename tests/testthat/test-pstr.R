test_that("`with_reductions` remains the same", {
  mvp <- mvp_path("product-sector-transition-risk.Rmd")
  out <- wrap_rmd(mvp)
  out <- out[["with_reductions"]]
  out <- format_robust_snapshot(out)
  expect_snapshot(out)
})

test_that("`with_transition_risk` remains the same", {
  mvp <- mvp_path("product-sector-transition-risk.Rmd")
  out <- wrap_rmd(mvp)
  out <- out[["with_transition_risk"]]
  out <- format_robust_snapshot(out)
  expect_snapshot(out)
})

test_that("`with_score_aggregated` remains the same", {
  mvp <- mvp_path("product-sector-transition-risk.Rmd")
  out <- wrap_rmd(mvp)
  out <- out[["with_score_aggregated"]]
  out <- format_robust_snapshot(out)
  expect_snapshot(out)
})

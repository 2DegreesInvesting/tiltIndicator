test_that("`with_reductions` remains the same", {
  path <- mvp_path("product-sector-transition-risk.Rmd")
  with_reductions <- render_list(path)$with_reductions
  out <- format_robust_snapshot(with_reductions)

  expect_snapshot(out)
})

test_that("`with_transition_risk` remains the same", {
  path <- mvp_path("product-sector-transition-risk.Rmd")
  with_transition_risk <- render_list(path)$with_transition_risk
  out <- format_robust_snapshot(with_transition_risk)
  expect_snapshot(out)
})

test_that("`with_score_aggregated` remains the same", {
  path <- mvp_path("product-sector-transition-risk.Rmd")
  with_score_aggregated <- render_list(path)$with_score_aggregated
  out <- format_robust_snapshot(with_score_aggregated)
  expect_snapshot(out)
})

test_that("`with_reductions` remains the same", {
  path <- mvp_path("product-sector-transition-risk.Rmd")
  with_reductions <- render_list(path)$final_df
  out <- format_robust_snapshot(with_reductions)

  expect_snapshot(out)
})

test_that("`with_transition_risk` remains the same", {
  path <- mvp_path("product-sector-transition-risk.Rmd")
  with_transition_risk <- render_list(path)$final_df_cat
  out <- format_robust_snapshot(with_transition_risk)
  expect_snapshot(out)
})

test_that("`with_score_aggregated` remains the same", {
  mvp <- mvp_path("product-sector-transition-risk.Rmd")
  out <- wrap_rmd(mvp)
  out <- out[["with_score_aggregated"]]
  out <- format_robust_snapshot(out)
  expect_snapshot(out)
})

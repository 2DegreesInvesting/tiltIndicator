test_that("`ecoinvent_scores` remains the same", {
  path <- mvp_path("pctr.Rmd")
  ecoinvent_scores <- render_to_list(path)$ecoinvent_scores
  out <- format_robust_snapshot(ecoinvent_scores)
  expect_snapshot(out)
})

test_that("`pctr_output` remains the same", {
  path <- mvp_path("pctr.Rmd")
  pctr_output <- render_to_list(path)$pctr_output
  out <- format_robust_snapshot(pctr_output)
  expect_snapshot(out)
})

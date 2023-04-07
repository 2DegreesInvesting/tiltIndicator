test_that("`ecoinvent_input` hasn't changed", {
  ecoinvent_input <- render_to_list(mvp_path("ictr.Rmd"))$ecoinvent_input
  out <- format_robust_snapshot(ecoinvent_input)
  expect_snapshot(out)
})

test_that("`ecoinvent_scores` hasn't changed", {
  ecoinvent_scores <- render_to_list(mvp_path("ictr.Rmd"))$ecoinvent_scores
  out <- format_robust_snapshot(ecoinvent_scores)
  expect_snapshot(out)
})

test_that("`pctr_output` hasn't changed", {
  pctr_output <- render_to_list(mvp_path("ictr.Rmd"))$pctr_output
  out <- format_robust_snapshot(pctr_output)
  expect_snapshot(out)
})

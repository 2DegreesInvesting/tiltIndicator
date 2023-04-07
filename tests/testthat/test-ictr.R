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

test_that("`scores_all` hasn't changed", {
  scores_all <- render_to_list(mvp_path("ictr.Rmd"))$scores_all
  out <- format_robust_snapshot(scores_all)
  expect_snapshot(out)
})

test_that("`scores_unit` hasn't changed", {
  scores_unit <- render_to_list(mvp_path("ictr.Rmd"))$scores_unit
  out <- format_robust_snapshot(scores_unit)
  expect_snapshot(out)
})

test_that("`scores_sector` hasn't changed", {
  scores_sector <- render_to_list(mvp_path("ictr.Rmd"))$scores_sector
  out <- format_robust_snapshot(scores_sector)
  expect_snapshot(out)
})

test_that("`scores_unit_sec` hasn't changed", {
  scores_unit_sec <- render_to_list(mvp_path("ictr.Rmd"))$scores_unit_sec
  out <- format_robust_snapshot(scores_unit_sec)
  expect_snapshot(out)
})

test_that("`pctr_output` hasn't changed", {
  pctr_output <- render_to_list(mvp_path("ictr.Rmd"))$pctr_output
  out <- format_robust_snapshot(pctr_output)
  expect_snapshot(out)
})

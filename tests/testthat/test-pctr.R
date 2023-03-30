test_that("`ecoinvent_ranks` remains the same", {
  path <- mvp_path("pctr.Rmd")
  ecoinvent_ranks <- render_to_list(path)$ecoinvent_ranks
  out <- format_robust_snapshot(ecoinvent_ranks)
  expect_snapshot(out)
})

test_that("`ecoinvent_scores` remains the same", {
  path <- mvp_path("pctr.Rmd")
  ecoinvent_scores <- render_to_list(path)$ecoinvent_scores
  out <- format_robust_snapshot(ecoinvent_scores)
  expect_snapshot(out)
})

test_that("`companies_scores` remains the same", {
  path <- mvp_path("pctr.Rmd")
  companies_scores <- render_to_list(path)$companies_scores
  out <- format_robust_snapshot(companies_scores)
  expect_snapshot(out)
})

test_that("`scores_all` remains the same", {
  path <- mvp_path("pctr.Rmd")
  scores_all <- render_to_list(path)$scores_all
  out <- format_robust_snapshot(scores_all)
  expect_snapshot(out)
})

test_that("`scores_unit` remains the same", {
  path <- mvp_path("pctr.Rmd")
  scores_unit <- render_to_list(path)$scores_unit
  out <- format_robust_snapshot(scores_unit)
  expect_snapshot(out)
})

test_that("`scores_unit_sec` remains the same", {
  path <- mvp_path("pctr.Rmd")
  scores_unit_sec <- render_to_list(path)$scores_unit_sec
  out <- format_robust_snapshot(scores_unit_sec)
  expect_snapshot(out)
})

test_that("`pctr_output` remains the same", {
  path <- mvp_path("pctr.Rmd")
  pctr_output <- render_to_list(path)$pctr_output
  out <- format_robust_snapshot(pctr_output)
  expect_snapshot(out)
})

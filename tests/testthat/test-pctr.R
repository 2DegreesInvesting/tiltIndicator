test_that("`scored_activities` remains the same", {
  path <- mvp_path("pctr.Rmd")
  scored_activities <- render_to_list(path)$scored_activities
  out <- format_robust_snapshot(scored_activities)
  expect_snapshot(out)
})

test_that("`scored_companies` remains the same", {
  path <- mvp_path("pctr.Rmd")
  scored_companies <- render_to_list(path)$scored_companies
  out <- format_robust_snapshot(scored_companies)
  expect_snapshot(out)
})

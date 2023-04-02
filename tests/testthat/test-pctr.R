test_that("`scored_companies` remains the same", {
  path <- mvp_path("pctr.Rmd")
  scored_companies <- render_to_list(path)$scored_companies
  out <- format_robust_snapshot(scored_companies)
  expect_snapshot(out)
})

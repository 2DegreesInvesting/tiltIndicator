test_that("`ecoinvent_ranks` remains the same", {
  path <- mvp_path("pctr.Rmd")
  ecoinvent_ranks <- render_to_list(path)$ecoinvent_ranks
  out <- format_robust_snapshot(ecoinvent_ranks)
  expect_snapshot(out)
})

test_that("`reshaped_istr_companies` remains the same", {
  path <- mvp_path("istr.Rmd")
  reshaped_istr_companies <- render_to_list(path)$reshaped_istr_companies
  out <- format_robust_snapshot(reshaped_istr_companies)
  expect_snapshot(out)
})

test_that("`istr_companies` remains the same", {
  path <- mvp_path("istr.Rmd")
  istr_companies <- render_to_list(path)$istr_companies
  out <- format_robust_snapshot(head(istr_companies))
  expect_snapshot(out)
})

test_that("`with_reductions` remains the same", {
  path <- mvp_path("istr.Rmd")
  with_reductions <- render_to_list(path)$with_reductions
  out <- format_robust_snapshot(head(with_reductions))
  expect_snapshot(out)
})


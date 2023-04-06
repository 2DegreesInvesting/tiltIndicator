test_that("`reshaped_istr_companies` remains the same", {
  skip("TODO ISTR")
  path <- mvp_path("istr.Rmd")
  reshaped_istr_companies <- render_list(path)$reshaped_istr_companies
  out <- format_robust_snapshot(reshaped_istr_companies)

  expect_snapshot(out)
})
